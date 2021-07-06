-- 01
ALTER TABLE table_name OWNER TO new_owner;
-- 02
GRANT UPDATE ON accounts TO joe;
-- 03 revoke privilege
REVOKE ALL ON accounts FROM PUBLIC;
