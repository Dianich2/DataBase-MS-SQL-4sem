select r.AdvertisingType, r.Duration from 
–≈ À¿Ã€ r where Duration >=any(select re.Duration from
–≈ À¿Ã€ re where Date like '2025-02-1%');