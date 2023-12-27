
      ## Analisis exploratorio de datos de la Energia Global Sostenible entre el 2000 y 2020

USE energia_sostenible;

SELECT * FROM global_energy;


## Primeras pruebas:

SELECT flujos_financieros_proyectos_USD, elect_comb_fosil_TWh, elect_nuclear_TWh, elect_energ_renov_TWh, 
	   consumo_energ_percapita_kWh, intens_energ_de_energ_primaria_MJ, emision_co2_percapita_Tm, 
       energ_prim_derv_renov_porct, crecimiento_PIB_porctAnual, densidad_Km2, area_terreno_Km2
FROM global_energy;


## 1. Países con menor acceso a electricidad en el mundo:

SELECT Pais, AVG(pb_acceso_elect)
FROM global_energy
GROUP BY Pais
ORDER BY AVG(pb_acceso_elect);

## 2. Año donde se generó mayor uso de energía 
















