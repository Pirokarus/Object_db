--DROP TABLE references_table;
--DROP TABLE attribute_binds;
--DROP TABLE params;
--DROP TABLE attributes_table;
--DROP TABLE objects;
--DROP TABLE object_types;
--DROP TABLE attribute_types;


CREATE TABLE attribute_types
(
  attribute_type_id    NUMBER         CONSTRAINT att_types_pk_att_types_id PRIMARY KEY,
  name                 VARCHAR2(255)  CONSTRAINT att_types_uk_name UNIQUE NOT NULL
);

CREATE TABLE object_types
(
  object_type_id    NUMBER         CONSTRAINT obj_types_pk_object_type_id PRIMARY KEY,
  name              VARCHAR2(255)  CONSTRAINT obj_types_uk_name UNIQUE NOT NULL,
  discription       VARCHAR2(255),
  parent_type_id    NUMBER         CONSTRAINT obj_types_fk_parent_type_id REFERENCES object_types (object_type_id)
);

CREATE TABLE objects
(
  object_id         NUMBER         CONSTRAINT objects_pk_object_id PRIMARY KEY,
  object_type_id    NUMBER         CONSTRAINT objects_fk_object_type_id REFERENCES object_types (object_type_id),
  name              VARCHAR2(255)  CONSTRAINT objects_uk_name UNIQUE NOT NULL,
  discription       VARCHAR2(255),
  container_id      NUMBER         CONSTRAINT objects_fk_container_id REFERENCES objects (object_id)
);

CREATE TABLE attributes_table
(
  attribute_id         NUMBER         CONSTRAINT att_table_pk_attribute_id PRIMARY KEY,
  attribute_type_id    NUMBER         CONSTRAINT att_table_fk_attribute_type_id REFERENCES attribute_types (attribute_type_id),
  name                 VARCHAR2(255)  CONSTRAINT att_table_uk_name UNIQUE NOT NULL,
  details              VARCHAR2(255),
  ismutible            NUMBER
);


CREATE TABLE params
(
  object_id          NUMBER         CONSTRAINT params_fk_object_id REFERENCES objects (object_id),
  attribute_id       NUMBER         CONSTRAINT params_fk_attribute_id REFERENCES attributes_table (attribute_id),
  text_value         VARCHAR2(255),
  number_value       NUMBER
);

CREATE TABLE attribute_binds
(
  attribute_id            NUMBER         CONSTRAINT att_binds_fk_attribute_id REFERENCES attributes_table (attribute_id),
  object_type_id          NUMBER         CONSTRAINT att_binds_fk_object_type_id REFERENCES object_types (object_type_id),
  description             VARCHAR2(255)
);

CREATE TABLE references_table
(
  object_id            NUMBER         CONSTRAINT ref_table_fk_object_id REFERENCES objects (object_id),
  attribute_id         NUMBER         CONSTRAINT ref_table_fk_attribute_id REFERENCES attributes_table (attribute_id),
  reference_id         NUMBER         CONSTRAINT ref_table_fk_reference_id REFERENCES objects (object_id)
);