import requests
from contracts.schema import GenericSchema
from typing import List

class ApiColector:
    def __init__(self, schema):
        self._schema = schema
        self._aws = None
        self.buffer = None
        return
    
    def start(self, param):
        response = self.getData(param)
        response = self.extractData(response)
        return response
    
    def getData(self, param):
        if param > 1:
            response = requests.get(f"http://localhost:8000/gerar_compra/{param}").json()
        else:
            response = requests.get("http://localhost:8000/gerar_compra").json()
        return response
    
    def extractData(self, response):
        result: List[GenericSchema] = []
        for item in response:
            index = {}
            for key, value in self._schema.items():
                if type(item.get(key)) == value:
                    index[key] = item[key]
                else:
                    index[key] = None

            result.append(index)
        return result
    
    def transform_data(self):
        return
    
