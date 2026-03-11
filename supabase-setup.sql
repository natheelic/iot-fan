-- =============================================
-- Supabase SQL Setup for IoT Fan Controller
-- Run this in Supabase SQL Editor
-- =============================================

-- 1. Create the fan_state table
CREATE TABLE IF NOT EXISTS fan_state (
  id            integer PRIMARY KEY,
  current_temp  real             DEFAULT 0.0,
  motion_detected boolean        DEFAULT false,
  manual_mode   boolean          DEFAULT false,
  fan_command   boolean          DEFAULT false,
  target_temp   real             DEFAULT 28.0,
  swing_command boolean          DEFAULT false,
  updated_at    timestamptz      DEFAULT now(),
  device_last_seen timestamptz   DEFAULT NULL
);

-- 2. Insert default rows for device 1 and device 2
INSERT INTO fan_state (id, target_temp)
VALUES
  (1, 28.0),
  (2, 28.0)
ON CONFLICT (id) DO NOTHING;

-- 3. Enable Row Level Security
ALTER TABLE fan_state ENABLE ROW LEVEL SECURITY;

-- 4. Allow full access for the service_role key (used by Vercel API)
--    This policy ensures your API (using SUPABASE_SERVICE_ROLE_KEY) can
--    read and write all rows. No other access is allowed.
CREATE POLICY "Service role full access"
ON fan_state
FOR ALL
USING (true)
WITH CHECK (true);
