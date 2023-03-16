CREATE MATERIALIZED VIEW vdata.vehicle_daily_data_usage AS
WITH vehicle_daily_counter AS (SELECT vehicle_id,
                                      max(fw_accept_bytes + fw_drop_bytes)             AS fw,
                                      max(apn0_tx_bytes + apn0_rx_bytes)               AS apn0,
                                      max(apn1_tx_bytes + apn1_rx_bytes)               AS apn1,
                                      max(apn2_tx_bytes + apn2_rx_bytes)               AS apn2,
                                      max(apn3_tx_bytes + apn3_rx_bytes)               AS apn3,
                                      max(sg_default_tx_bytes + sg_default_rx_bytes)   AS sg_default,
                                      max(sg_ccs_tx_bytes + sg_ccs_rx_bytes)           AS sg_ccs,
                                      max(sg_fota_tx_bytes + sg_fota_rx_bytes)         AS sg_fota,
                                      max(sg_oempaid_tx_bytes + sg_oempaid_rx_bytes)   AS sg_oempaid,
                                      max(sg_userpaid_tx_bytes + sg_userpaid_rx_bytes) AS sg_userpaid,
                                      max(sg_vcrm_tx_bytes + sg_vcrm_rx_bytes)         AS sg_vcrm,
                                      max(sg_canids_tx_bytes + sg_canids_rx_bytes)     AS sg_canids,
                                      max(event_time)                                  as et
                               FROM vdata.vehicle_vcc_stat
                               GROUP BY vehicle_id, date_trunc('day', event_time))