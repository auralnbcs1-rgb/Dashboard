-- Agrega "Asistieron" y "Con pérdida auditiva" a la tabla pautas que ya existe.
-- Ejecútalo UNA vez en Supabase → SQL Editor → New query → Run. No borra datos.

alter table public.pautas add column if not exists asistieron integer not null default 0 check (asistieron >= 0);
alter table public.pautas add column if not exists perdida    integer not null default 0 check (perdida >= 0);

alter table public.pautas drop constraint if exists asistieron_menor_agendados;
alter table public.pautas drop constraint if exists perdida_menor_asistieron;
alter table public.pautas add constraint asistieron_menor_agendados check (asistieron <= agendados);
alter table public.pautas add constraint perdida_menor_asistieron   check (perdida <= asistieron);

-- Refresca la API para que reconozca las columnas nuevas de inmediato.
notify pgrst, 'reload schema';
