UPDATE public.teacher SET
bio = 'Thích đọc sách'::text, updated_at = 'now()'::timestamp with time zone WHERE
id = 1;

UPDATE public.teacher SET
bio = 'Thích đá bóng'::text, updated_at = 'now()'::timestamp with time zone WHERE
id = 2;

UPDATE public.teacher SET
bio = 'Thích đi du lịch'::text, updated_at = 'now()'::timestamp with time zone WHERE
id = 3;