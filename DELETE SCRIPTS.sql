delete from tb_mst_process_config where process_id in (5555) and (key_value='4600' or key_value='4700' or key_value='4800');
delete from tb_mst_process_config where process_id in (24,25,4600,4700,4800);
delete from tb_mst_query_store where identifier like '%NOOP%';
delete from tb_mst_map_headers_columns where process_id in (24,25,4600,4700,4800);
delete from tb_mst_process where process_id in (24,25,4600,4700,4800);
delete from tb_mst_product_config where product_id=23;
delete from tb_mst_products where product_id=23;