CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE IF NOT EXISTS public.sim_ids (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  person_id uuid NOT NULL REFERENCES public.persons(id) ON DELETE RESTRICT,
  token text NOT NULL UNIQUE,
  status text NOT NULL DEFAULT 'Active',
  issued_at timestamptz NOT NULL DEFAULT now(),
  expires_at timestamptz,
  revoked_at timestamptz
);

CREATE TABLE IF NOT EXISTS public.sim_id_scans (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  sim_id uuid NOT NULL REFERENCES public.sim_ids(id) ON DELETE RESTRICT,
  officer_id uuid NULL,
  scanned_at timestamptz NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS sim_ids_token_idx ON public.sim_ids(token);
CREATE INDEX IF NOT EXISTS sim_ids_person_idx ON public.sim_ids(person_id);
CREATE INDEX IF NOT EXISTS sim_scans_sim_idx ON public.sim_id_scans(sim_id);
