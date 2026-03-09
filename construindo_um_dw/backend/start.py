from datasource.api import ApiColector
from contracts.schema import CompraSchema


schema = CompraSchema
minha_api = ApiColector(schema).start(5)

print(minha_api)