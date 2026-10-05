-- Tablero Pautas Aural: tabla, seguridad y tiempo real.
-- Ejecútalo una sola vez en Supabase → SQL Editor → New query → Run.

create table if not exists public.pautas (
  id          uuid primary key default gen_random_uuid(),
  nombre      text not null,
  plataforma  text not null,
  mes         text not null check (mes ~ '^\d{4}-\d{2}$'),   -- formato AAAA-MM
  sede        text not null,
  inversion   numeric not null default 0 check (inversion >= 0),
  leads       integer not null default 0 check (leads >= 0),
  agendados   integer not null default 0 check (agendados >= 0),
  ventas      integer not null default 0 check (ventas >= 0),
  ingresos    numeric check (ingresos >= 0),
  actualizado timestamptz not null default now(),
  constraint agendados_menor_leads check (agendados <= leads),
  constraint ventas_menor_leads   check (ventas <= leads)
);

create index if not exists pautas_mes_idx on public.pautas (mes);

-- Acceso abierto: cualquiera con la URL del sitio puede ver, registrar, editar y borrar.
alter table public.pautas enable row level security;

drop policy if exists "pautas_leer"      on public.pautas;
drop policy if exists "pautas_insertar"  on public.pautas;
drop policy if exists "pautas_editar"    on public.pautas;
drop policy if exists "pautas_borrar"    on public.pautas;

create policy "pautas_leer"     on public.pautas for select to anon, authenticated using (true);
create policy "pautas_insertar" on public.pautas for insert to anon, authenticated with check (true);
create policy "pautas_editar"   on public.pautas for update to anon, authenticated using (true) with check (true);
create policy "pautas_borrar"   on public.pautas for delete to anon, authenticated using (true);

-- Actualizaciones en vivo entre usuarios.
alter publication supabase_realtime add table public.pautas;
