
			 ## Análisis de datos de la Energía Global Sostenible entre el 2000 y 2019
      

CREATE DATABASE energia_sostenible;

USE energia_sostenible;

SELECT * FROM global_energy;



## 1. Cinco Países con menor porcentaje de población con acceso a electricidad durante el periodo 2000-2019:

SELECT Pais, MIN(pb_acceso_elect_porct) AS MIN_pob_AccElect
FROM global_energy
GROUP BY Pais
ORDER BY MIN_pob_AccElect ASC
LIMIT 5;


## 2. ¿Qué país ha participado en el registro de datos de energía sostenible durante todo el periodo 2000-2019?:

SELECT Pais, COUNT(DISTINCT Año) AS Num_participaciones
FROM global_energy
GROUP BY Pais
HAVING Num_participaciones = (SELECT COUNT(DISTINCT Año) AS Total_años
							 FROM global_energy);
							
                            
## 3. Máxima Emisión de Dióxido de carbono per capita de los 10 paises con mayor densidad poblacional en los últimos 5 años:

SELECT global_energy.Pais, MAX(global_energy.densidad_Km2) AS Densidad, MAX(global_energy.emision_co2_percapita_Tm) AS CO2_percapita
FROM global_energy
INNER JOIN			(SELECT DISTINCT Pais, densidad_Km2
					FROM global_energy
					WHERE Año >= 2015 AND Año <= 2019
					ORDER BY densidad_Km2 DESC
					LIMIT 10) AS pais_MAYdensidad
ON global_energy.Pais = pais_MAYdensidad.Pais
GROUP BY global_energy.Pais
ORDER BY CO2_percapita DESC;


## 4. ¿En qué año es mayor el porcentaje de la población con acceso a combustible limpio para cocinar?:

SELECT Año, MAX(pb_combustible_limp_porct)
FROM global_energy
GROUP BY Año
ORDER BY MAX(pb_combustible_limp_porct) DESC
LIMIT 1;


## 5. Electricidad generada por los tres tipos de energía por país:

SELECT Pais, elect_comb_fosil_TWh, elect_nuclear_TWh, elect_energ_renov_TWh
FROM global_energy
ORDER BY elect_comb_fosil_TWh DESC;
                           
                             
## 6. Top15 países con mayor porcentaje de población con acceso a la electricidad:

SELECT Pais, MAX(pb_acceso_elect_porct)
FROM global_energy
GROUP BY Pais
ORDER BY MAX(pb_acceso_elect_porct) DESC
LIMIT 15;


## 7. País de menor y mayor capacidad instalada de energía renovable per_capita durante el 2015-2019:

(SELECT Pais, MIN(cap_generac_energ_renov_percapita) AS CG_ER_percapita
FROM global_energy
WHERE Año >= 2015
GROUP BY Pais
ORDER BY CG_ER_percapita ASC
LIMIT 1)
UNION
(SELECT Pais, MAX(cap_generac_energ_renov_percapita) AS CG_ER_percapita
FROM global_energy
WHERE Año >= 2015
GROUP BY Pais
ORDER BY CG_ER_percapita DESC
LIMIT 1);


## 8. Capacidad instalada de energía renovable per_capita de Colombia:

SELECT Año, Pais, cap_generac_energ_renov_percapita
FROM global_energy
WHERE Pais = 'Colombia';


## 9. Top20 de países que aportaron mayor capital en proyectos de energía limpia hacia países en desarrollo:

SELECT Pais, SUM(flujos_financieros_proyectos_USD)
FROM global_energy
GROUP BY Pais
ORDER BY SUM(flujos_financieros_proyectos_USD) DESC
LIMIT 20;


## 10. Porcentaje más alto y bajo de energía renovable del consumo total de energía final por año:
   
(SELECT Año, MAX(energ_renov_consumoTOTAL_porct) AS ER_consTotalXAño
FROM global_energy
GROUP BY Año
ORDER BY ER_consTotalXAño DESC
LIMIT 1)
UNION
(SELECT Año, MIN(energ_renov_consumoTOTAL_porct) AS ER_consTotalXAño
FROM global_energy
GROUP BY Año
ORDER BY MIN(energ_renov_consumoTOTAL_porct) ASC
LIMIT 1);
  
  
## 11. Cuántos países participaron durante el periodo 2000-2019 en el registro de datos de energía sostenible?:

SELECT COUNT( DISTINCT Pais) AS Total_paises 
FROM global_energy;


## 12. País con mayor porcentaje de energía renovable del consumo total de energía final:

SELECT Pais, MAX(energ_renov_consumoTOTAL_porct)
FROM global_energy
GROUP BY Pais
ORDER BY MAX(energ_renov_consumoTOTAL_porct) DESC
LIMIT 1;


## 13. ¿Cuántas veces ha participado cada nación en el registro de indicadores de energía sostenible durante el periodo 2000-2019?:

SELECT Pais, COUNT(*) AS Cantidad_participacion
FROM global_energy
GROUP BY Pais
ORDER BY Cantidad_participacion DESC;


## 14. Porcentaje más alto de energía renovable del consumo total de energía final en el 2017, 2018 y 2019:

SELECT Año, MAX(energ_renov_consumoTOTAL_porct)
FROM global_energy
WHERE Año IN (2017, 2018, 2019)
GROUP BY Año;


## 15. Electricidad generada de combustibles fósiles (carbón, petróleo y gas) Twh para Colombia, China:

SELECT Pais, Año, elect_comb_fosil_TWh
FROM global_energy
WHERE Pais IN ('Colombia', 'China');


## 16. ¿Cuántos países participaron para cada año?

SELECT Año, COUNT(DISTINCT Pais) AS Num_paisesXAño
FROM global_energy
GROUP BY Año;


## 17. Electricidad total generada a partir de los diferentes tipos de energía:

SELECT SUM(elect_comb_fosil_TWh) AS Total_elect_Fosil , SUM(elect_nuclear_TWh) AS Total_elect_Nuclear, 
       SUM(elect_energ_renov_TWh) AS Total_elect_EnergRenovable
FROM global_energy;


## 18. Top15 países con mayor porcentaje de electricidad procedente de fuentes bajas en carbono durante el periodo 2015-2019:

SELECT Año, Pais, MAX(elect_baja_carbono_porct) AS Elect_deriv_Carbono
FROM global_energy
WHERE  Año >= 2015 
GROUP BY Pais, Año
ORDER BY MAX(elect_baja_carbono_porct) DESC
LIMIT 15;


## 19. Consumo de energía primaria per capita de cada país:
							
SELECT Pais, AVG(consumo_energPRIM_percapita_kWh)
FROM global_energy
GROUP BY Pais
ORDER BY AVG(consumo_energPRIM_percapita_kWh) DESC;

## 20. Mayor emisión de dióxido de carbono (CO2) per capita de países que participaron durante todo el periodo:

CREATE TEMPORARY TABLE 20partXPais
(SELECT Pais, COUNT(DISTINCT Año) AS Num_participaciones
FROM global_energy
GROUP BY Pais
HAVING Num_participaciones = (SELECT COUNT(DISTINCT Año) AS Total_años
							 FROM global_energy));
                             
     SELECT * FROM 20partXPais;

CREATE TEMPORARY TABLE CO2_percapita 
SELECT Pais, AVG(emision_co2_percapita_Tm) AS CO2_percapita_Tm
FROM global_energy
GROUP BY Pais
ORDER BY CO2_percapita_Tm DESC;

     SELECT * FROM CO2_percapita; 

SELECT CO2_percapita.Pais, CO2_percapita.CO2_percapita_Tm 
FROM CO2_percapita
INNER JOIN 20partXPais
ON 20partXPais.Pais = CO2_percapita.Pais;
                             
                             
## 21. Porcentaje de energía primaria que se deriva de fuentes renovables de cada país:

SELECT Pais, Año, energ_prim_derv_renov_porct AS EnergP_FRenovable
FROM global_energy
ORDER BY energ_prim_derv_renov_porct DESC;


## 22. Top15 países de mayor crecimiento anual del PIB en el 2019:

SELECT Pais, Año, crecimiento_PIB_porctAnual
FROM global_energy
WHERE Año = 2019
ORDER BY crecimiento_PIB_porctAnual DESC
LIMIT 15;


## 23. Top10 de países con mejor PIB percapita durante el periodo 2010-2019:

SELECT Pais, Año, PIB_percapita 
FROM global_energy
WHERE Año >= 2010
ORDER BY PIB_percapita DESC
LIMIT 10;


## 24. Mayor y menor densidad de población (km2) de países que participaron durante los últimos 5 años:

(SELECT DISTINCT Pais, densidad_Km2
FROM global_energy
WHERE Año >= 2015 AND Año <= 2019
ORDER BY densidad_Km2 ASC
LIMIT 1)
UNION 
(SELECT DISTINCT Pais, densidad_Km2
FROM global_energy
WHERE Año >= 2015 AND Año <= 2019
ORDER BY densidad_Km2 DESC
LIMIT 1);









