select r.AdvertisingType, r.Duration from 
������� r where Duration >=any(select re.Duration from
������� re where Date like '2025-02-1%');