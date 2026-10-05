# Pautas Aural — publicación en Netlify + Supabase

Archivos:
- `index.html` — el tablero (acceso abierto, sin clave).
- `config.js` — URL y anon key de Supabase (lo único que debes editar).
- `supabase.sql` — crea la tabla `pautas` con acceso abierto (instalación nueva).
- `actualizacion-asistencia.sql` — agrega Asistieron y Con pérdida a una tabla que ya existe.

## 1. Supabase (5 min)
1. Puedes usar el mismo proyecto de la agenda o crear uno nuevo en supabase.com.
2. SQL Editor → New query → pega `supabase.sql` → **Run**.
   - Si dice que `pautas` ya está en `supabase_realtime`, ignóralo.
3. Project Settings → API: copia **Project URL** y la key **anon public**.

## 2. Configurar
Abre `config.js` y reemplaza `SUPABASE_URL` y `SUPABASE_ANON_KEY`.

## 3. Netlify (2 min)
- Rápido: entra a app.netlify.com → **Add new site → Deploy manually** y
  arrastra esta carpeta completa. Luego en *Site configuration → Change site name*
  ponle algo como `pautas-aural` → quedará en `pautas-aural.netlify.app`.
- O con la CLI: `netlify deploy --prod --dir .` dentro de esta carpeta.

## Seguridad
- Sin clave: cualquiera que tenga la URL puede ver, editar y borrar registros.
  Comparte el enlace solo con el equipo y usa un nombre de sitio poco obvio.
- El sitio tiene `noindex` para que Google no lo muestre.
- Si luego quieres clave, se puede volver a activar el inicio de sesión.
- Respaldo: usa el botón Exportar CSV de vez en cuando.
