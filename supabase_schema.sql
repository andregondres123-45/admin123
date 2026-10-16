-- INVENTRA Cloud: jalankan seluruh script ini di Supabase > SQL Editor > New query.
create table if not exists public.inventra_state (
  id integer primary key check (id = 1),
  data jsonb not null default '{"items":[],"tx":[],"refs":{}}'::jsonb,
  updated_at timestamptz not null default now(),
  updated_by uuid references auth.users(id)
);

alter table public.inventra_state enable row level security;

-- Pengguna yang sudah login dapat membaca state warehouse.
drop policy if exists "Authenticated users can read INVENTRA state" on public.inventra_state;
create policy "Authenticated users can read INVENTRA state"
  on public.inventra_state for select to authenticated using (true);

-- Pengguna yang sudah login dapat menyimpan state warehouse.
drop policy if exists "Authenticated users can insert INVENTRA state" on public.inventra_state;
create policy "Authenticated users can insert INVENTRA state"
  on public.inventra_state for insert to authenticated with check (true);

drop policy if exists "Authenticated users can update INVENTRA state" on public.inventra_state;
create policy "Authenticated users can update INVENTRA state"
  on public.inventra_state for update to authenticated using (true) with check (true);

grant select, insert, update on public.inventra_state to authenticated;
