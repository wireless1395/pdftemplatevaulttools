-- Run in Supabase SQL Editor. Review and test before production.
create table if not exists public.products(id text primary key,name text not null,description text not null,category text not null,price_minor integer not null check(price_minor>=0),currency text not null default 'NGN',active boolean not null default true,file_path text,created_at timestamptz not null default now());
create table if not exists public.orders(id uuid primary key default gen_random_uuid(),user_id uuid not null references auth.users(id) on delete cascade,product_id text not null references public.products(id),provider text not null check(provider in ('paystack','flutterwave')),provider_reference text unique,amount_minor integer not null check(amount_minor>=0),currency text not null default 'NGN',status text not null default 'pending' check(status in ('pending','paid','failed','refunded')),created_at timestamptz not null default now());
create table if not exists public.profiles(id uuid primary key references auth.users(id) on delete cascade,display_name text,is_admin boolean not null default false,created_at timestamptz not null default now());
alter table public.products enable row level security; alter table public.orders enable row level security; alter table public.profiles enable row level security;
create policy "Active products are public" on public.products for select using(active=true);
create policy "Users read own orders" on public.orders for select using(auth.uid()=user_id);
create policy "Users read own profile" on public.profiles for select using(auth.uid()=id);
-- Admin changes must go through server functions that verify an allowlist. Never trust browser-supplied admin flags.
