select r.AdvertisingType, r.Duration from 
������� r where Duration >=all(select re.Duration from
������� re where Date like '2025-02-1%');