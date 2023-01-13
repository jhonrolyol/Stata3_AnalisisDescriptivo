*================
* DOCUMENTACIÓN * --------------------------------------------------------------
*================

* Topic: Análisis descriptivo usando STATA 16
* Name: JR
* Date: January 06, 2023

*=========
* PAUTAS * ---------------------------------------------------------------------
*=========

* 1.- Usar "control + s" para guardar el Do-file.
* 2.- Usar "control + n" para crear un nuevo Do-file
* 3.- 

*=========
* REMOVE * ---------------------------------------------------------------------
*=========
 
 cls
 clear all
 set more off
 capture log close

*=======
* PATH * -----------------------------------------------------------------------
*=======

 pwd
 cd "D:\JR-STATA\Practice\STATA_AnalisisDescriptivo"
 pwd

*===================
* IMPORTAR LA BBDD *------------------------------------------------------------
*===================

 use "BBDD_Framingham.dta", clear
 br
 
*========================
* VARIABLES CATEGÓRICAS *-------------------------------------------------------
*========================

 describe
 tabulate death 
 ta death 
 
*===========================
* RESUMIR VARIAS VARIABLES *----------------------------------------------------
*=========================== 
  
 tab1 death diabetes1 stroke
 
*==================
* TABLAS CRUZADAS *-------------------------------------------------------------
*==================

 ta diabetes1 death 

 *=======================
 * Porcentaje por celda *-------------------------------------------------------
 *=======================
 
	ta diabetes1 death, cel
 
 *=========================
 * Porcentaje por columna *-----------------------------------------------------
 *=========================
 
	ta diabetes1 death, col
 
 *======================
 * Porcentaje por fila *--------------------------------------------------------
 *======================
 
	ta diabetes1 death, row
 
*===========
* GRÁFICOS *--------------------------------------------------------------------
*===========

 *=========
 * Barras *---------------------------------------------------------------------
 *=========

	graph bar (count) randid, over(sex1)

 *======
 * Pie *------------------------------------------------------------------------
 *======

	graph pie, over(sex1)

	*=====================
	* Pie más estilizado *------------------------------------------------------
	*=====================
	
		graph pie, over(sex1) plabel(_all percent, size(*2) color(white))

*==========================
* VARIABLES CUANTITATIVAS *-----------------------------------------------------
*==========================
 
 describe
 summarize age1 
 su age1 
 su age1, detail
 su age1, d
 
*=================================
* RESUMEN DE MULTIPLES VARIABLES *----------------------------------------------
*=================================
 
 su age1 glucose1 glucose2 glucose3 heartrte1
 su age1 glucose1 glucose2 glucose3 heartrte1, detail
 
*================
* CONDICIONALES *---------------------------------------------------------------
*================ 
 
 *===========
 * Por edad *-------------------------------------------------------------------
 *===========
 
	sum glucose1 if age1 >= 65, d 
 
 *===========
 * Por sexo *-------------------------------------------------------------------
 *===========
 
	sum totchol1 if sex1 == 2
	
	*=======
	* Note *--------------------------------------------------------------------
	*=======
		
		* Se usa el 2 para referirse a las mujeres
		
 *=======================
 * Con varias variables *-------------------------------------------------------
 *=======================
 
	su sysbp1 diabp1 if age1 >= 65, d 
	su sysbp1 diabp1 if sex1 == 2, d
 
*=========
* BYSORT *----------------------------------------------------------------------
*========= 
 
 bysort sex1: su glucose1
 bysort sex1: su glucose1, d
 
*=======================
* TABLAS MÁS ORDENADAS *--------------------------------------------------------
*=======================  
 
 tabstat glucose1
 
 *=======
 * Note *-----------------------------------------------------------------------
 *=======
 
	* mean : media, media aritmética o promedio aritmético
	* sd: desviación estandar
	* p50: percentil 50
	* p25: percentil 25 o Q1
	* p75: percentil 75 o Q3
	* min: valor mínimo
	* max: valor máximo
	* cv: coeficiente de variación (se usa para ver si se usa la media o mediana)
 
 *===========
 * Ejemplos *-------------------------------------------------------------------
 *===========
 
 tabstat glucose1, statistics(mean sd)
 tabstat glucose1, statistics(min p25 p50 p75 max)
 tabstat glucose1, s(min p25 p50 p75 max)	
 
 tabstat glucose1 glucose2 glucose3, s(min p25 p50 p75 max)
 tabstat glucose1 glucose2 glucose3, s(min p25 p50 p75 max) c(s)
 
 *========================
 * Condicionales if y by *------------------------------------------------------
 *========================
 
 tabstat glucose1 glucose2 glucose3 if age1 >= 65, by(sex1) s(min p25 p50 p75 max) c(s)
 
*===========
* GRÁFICOS *--------------------------------------------------------------------
*===========
 
 histogram glucose1
 hist glucose1
 
 hist glucose1 glucose2 // Genera error
 
 *================
 * Condicionales *--------------------------------------------------------------
 *================
 
 hist glucose1 if age1 >= 65
 
 *====================
 * Comparamos con by *----------------------------------------------------------
 *====================
 
 hist glucose1, by(sex1)
 
 *========================
 * Especificando con bin *------------------------------------------------------
 *========================
 
 hist glucose1, bin(10) // Muestra 10 barras
 
 *==========================
 * Especificando con width *----------------------------------------------------
 *==========================
 
 hist glucose1, width(5) // cada barra de 5 en 5
 hist glucose1, width(20) // cada barra de 20 en 20
 
*====================
* GRÁFICOS DE CAJAS *-----------------------------------------------------------
*==================== 
 
 *================
 * Caja vertical *--------------------------------------------------------------
 *================
 
  graph box glucose1
  
 *================
 * Caja horizontal *------------------------------------------------------------
 *================
  
  graph hbox glucose1
 
 *====================================
 * Condicionales por sexo (separado) *------------------------------------------
 *====================================
  
  graph hbox glucose1, by(sex1)
  
 *=========================================
 * Condicionales por sexo (misma gráfica) *-------------------------------------
 *=========================================
 
  graph hbox glucose1, over(sex1)
 
 *=================
 * Condicional if *-------------------------------------------------------------
 *=================
 
  graph box glucose1 if age1 > 60
  graph box glucose1 if age1 > 60, over(diabetes1)
 
 *================
 * Más complejas *--------------------------------------------------------------
 *================
  
  graph box glucose*, over(sex1)
  graph hbox glucose* if age1 > 65, over(sex1) over(stroke) noout 
  
  *=======
  * Note *----------------------------------------------------------------------
  *=======
  
	* El noout en este caso significa que no va mostrar los datos atípicos (outliers)
 

