![mi-flujo](https://github.com/fsalazar89/mi-documentacion/blob/procesos-git/imagenes/mi-flujo-git.png)

# Flujo de Trabajo para Despliegue de nuevas Funcionalidades

Este documento describe el flujo de trabajo para desarrollar, probar y desplegar funcionalidades en producción, garantizando que solo las funcionalidades aprobadas se desplieguen sin afectar otras que aún están en pruebas. Cada desarrollador trabajará en una rama independiente, y este proceso permitirá la integración controlada en cada etapa.

## Flujo General de Pasos

1. **Paso 1:** Crear una rama nueva para el desarrollo de la funcionalidad.
2. **Paso 2:** Integrar la rama de desarrollo en la rama `pruebas`.
3. **Paso 3:** Integrar la funcionalidad aprobada en la rama `produccion`.
4. **Paso 4:** Sincronizar la rama `main` con la rama `produccion`.

---

## Paso 1: Crear una Rama Nueva de Desarrollo

1. **Clonar el repositorio desde el servidor:**
   ```
   git clone <url-del-repositorio>
   cd <nombre-del-repositorio>
   ```
2. **Crear una rama de desarrollo (`cotizador`) basada en `main`:**
   ```
   git checkout main 
   git pull origin main # Traer la última versión de `main` desde el servidor 
   git checkout -b cotizador
   ```
   Ahora tienes una rama `cotizador` basada en `main`, donde comenzarás a trabajar en la funcionalidad de cotización.

## Paso 2: Desarrollar y Enviar los Cambios a `pruebas`
1. **Desarrollar la funcionalidad en la rama `cotizador` y realizar commits locales:**
   ```
   git add .
   git commit -m "Desarrollando funcionalidad de cotizador - parte X"
   ```
2. **Mantener sincronizado el desarrollo de `cotizador` con la rama `pruebas` en el servidor:**
   - Esto es importante para evitar conflictos si otros desarrolladores han añadido cambios a `pruebas`.
   ```
   git fetch origin  # Actualiza la información de las ramas remotas
   git checkout pruebas
   git pull origin pruebas  # Trae los cambios más recientes de `pruebas`
   git checkout cotizador
   git merge pruebas  # Fusiona los cambios de `pruebas` en `cotizador`
   ```
   - Si hay conflictos, resuélvelos y realiza un commit para actualizar `cotizador`.

3. **Fusionar la rama `cotizador` en `pruebas` y enviar al servidor:**
   ```
   git checkout pruebas
   git merge cotizador  # Fusiona `cotizador` en `pruebas`
   git push origin pruebas  # Enviar los cambios de `pruebas` al servidor

   ```
   - La funcionalidad de `cotizador` ahora estará disponible en la rama `pruebas` para que el equipo de negocio pueda realizar pruebas.

## Paso 3: Enviar la Funcionalidad Aprobada a `producción`
Después de la aprobación del equipo de negocio, enviar solo los cambios de la funcionalidad `cotizador` a `producción`, sin afectar otras funcionalidades en `pruebas` que no están listas. Para esto, utilizamos `cherry-pick` para llevar únicamente los commits de `cotizador` a `producción`.

1. **Aplicar los commits de `cotizador` en `producción` usando `cherry-pick`:**
   ```
   git checkout producción
   git cherry-pick <commit-id-1> <commit-id-2> ...  # Lista de IDs de commits de `cotizador`
   ```
2. **Enviar los cambios de `produccion` al servidor:**
   ```
   git push origin produccion
   ```
   - La funcionalidad `cotizador` se encuentra ahora en `produccion` sin incluir las demás funcionalidades de `pruebas`.

## Paso 4: Sincronizar la Rama `main` con `produccion`
Para mantener `main` actualizado con `producción`, sigue estos pasos:
1. **Fusionar `produccion` en `main`:**
   ```
   git checkout main
   git merge produccion
   ```
    
2.  **Enviar los cambios de `main` al servidor:**
   ```
   git push origin main
   ```
   - La rama `main` ahora refleja el estado actual de `produccion`, manteniéndola sincronizada.
    

* * *

Resumen de Comandos
-------------------

1.  **Crear y trabajar en la rama `cotizador`:**
   ```
   git checkout main 
   git pull origin main 
   git checkout -b cotizador
   ```
    
2.  **Mantener `cotizador` sincronizado con `pruebas`:**
   ```
   git fetch origin 
   git checkout pruebas 
   git pull origin pruebas 
   git checkout cotizador git merge pruebas
   ```
    
3.  **Fusionar `cotizador` en `pruebas` y enviar al servidor:**
   ```
   git checkout pruebas 
   git merge cotizador 
   git push origin pruebas
   ```
    
4.  **Hacer `cherry-pick` de los commits de `cotizador` en `producción` y enviar al servidor:**
   ```
   git checkout produccion
   git cherry-pick <commit-id-1> <commit-id-2> ... 
   git push origin produccion
   ```
    
5.  **Fusionar `produccion` en `main` y enviar al servidor:**
   ```
   git checkout main 
   git merge produccion 
   git push origin main
   ```

