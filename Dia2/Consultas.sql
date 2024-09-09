-- Muestre las regions con sus departamentos. Generar una columna con la cantidad de municipios por departamento.
select region, departamento, count(municipio) as total_municipios
from regiones
group by region, departamento;

-- Muestre los departamentos con sus municipios. Generar una columna con el codigo del municipio completo (codigo del departamento y municipio concatenados)
select departamento, municipio, concat(codigo_departamento,codigo_municipio) as Codigo_Municipio_Completo
from regiones;

-- trigger para que actualize total_habitantes y total_trabajadores cada que se cree, actualize o elimine un dato en la tabla regiones.
alter table regiones
add column total_trabajadores int;

alter table regiones
add column total_habitantes int;

CREATE OR REPLACE FUNCTION actualizar_totales_region() RETURNS TRIGGER AS $$
BEGIN
    IF (TG_OP = 'INSERT') THEN
        -- Incrementar los totales para la región de la fila insertada
        UPDATE regiones
        SET total_trabajadores = COALESCE(total_trabajadores, 0) + NEW.total_trabajadores,
            total_habitantes = COALESCE(total_habitantes, 0) + NEW.total_habitantes
        WHERE region = NEW.region;
    ELSIF (TG_OP = 'UPDATE') THEN
        -- Ajustar los totales para la región de la fila actualizada
        UPDATE regiones
        SET total_trabajadores = COALESCE(total_trabajadores, 0) - OLD.total_trabajadores + NEW.total_trabajadores,
            total_habitantes = COALESCE(total_habitantes, 0) - OLD.total_habitantes + NEW.total_habitantes
        WHERE region = NEW.region;
    ELSIF (TG_OP = 'DELETE') THEN
        -- Disminuir los totales para la región de la fila eliminada
        UPDATE regiones
        SET total_trabajadores = COALESCE(total_trabajadores, 0) - OLD.total_trabajadores,
            total_habitantes = COALESCE(total_habitantes, 0) - OLD.total_habitantes
        WHERE region = OLD.region;

        -- Opcional: eliminar la fila si los totales llegan a cero
        IF (SELECT total_trabajadores FROM regiones WHERE region = OLD.region) = 0 AND
           (SELECT total_habitantes FROM regiones WHERE region = OLD.region) = 0 THEN
            DELETE FROM regiones WHERE region = OLD.region;
        END IF;
    END IF;
    
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trigger_insert_regiones
AFTER INSERT ON regiones
FOR EACH ROW
EXECUTE FUNCTION actualizar_totales_region();


CREATE TRIGGER trigger_update_regiones
AFTER UPDATE ON regiones
FOR EACH ROW
EXECUTE FUNCTION actualizar_totales();


CREATE TRIGGER trigger_delete_regiones
AFTER DELETE ON regiones
FOR EACH ROW
EXECUTE FUNCTION actualizar_totales();
