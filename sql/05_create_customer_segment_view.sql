-- View: opspilot.vw_customer_segment_performance

-- DROP VIEW opspilot.vw_customer_segment_performance;

CREATE OR REPLACE VIEW opspilot.vw_customer_segment_performance
 AS
 WITH shipment_summary AS (
         SELECT fact_shipments.order_id,
            count(*) AS shipment_count,
            count(*) FILTER (WHERE fact_shipments.delay_days > 0) AS delayed_shipments
           FROM opspilot.fact_shipments
          GROUP BY fact_shipments.order_id
        ), return_summary AS (
         SELECT fact_returns.order_id,
            count(*) AS return_count
           FROM opspilot.fact_returns
          GROUP BY fact_returns.order_id
        )
 SELECT c.customer_segment,
    c.region,
    count(o.order_id) AS total_orders,
    round(sum(o.order_value), 2) AS total_revenue,
    round(avg(o.order_value), 2) AS average_order_value,
    count(o.order_id) FILTER (WHERE COALESCE(s.delayed_shipments, 0::bigint) > 0) AS delayed_orders,
    round(100.0 * sum(COALESCE(s.delayed_shipments, 0::bigint)) / NULLIF(sum(COALESCE(s.shipment_count, 0::bigint)), 0::numeric), 2) AS late_shipment_rate_pct,
    count(o.order_id) FILTER (WHERE COALESCE(r.return_count, 0::bigint) > 0) AS total_returns,
    round(100.0 * count(o.order_id) FILTER (WHERE COALESCE(r.return_count, 0::bigint) > 0)::numeric / NULLIF(count(o.order_id), 0)::numeric, 2) AS return_rate_pct
   FROM opspilot.fact_orders o
     JOIN opspilot.dim_customer c ON o.customer_id::text = c.customer_id::text
     LEFT JOIN shipment_summary s ON o.order_id::text = s.order_id::text
     LEFT JOIN return_summary r ON o.order_id::text = r.order_id::text
  GROUP BY c.customer_segment, c.region;

ALTER TABLE opspilot.vw_customer_segment_performance
    OWNER TO postgres;

