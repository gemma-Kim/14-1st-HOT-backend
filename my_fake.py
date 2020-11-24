from faker import Faker

kofake = Faker('ko_KR')
enfake = Faker('en_EN')

shipment        = kofake.name()
tracking_number = enfake.random_number()
company         = enfake.name()
