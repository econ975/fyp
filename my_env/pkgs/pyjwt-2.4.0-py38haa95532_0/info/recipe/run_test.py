import jwt


key = "secret"
encoded = jwt.encode({"some": "payload"}, key, algorithm="HS256")

assert encoded == 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzb21lIjoicGF5bG9hZCJ9.Joh1R2dYzkRvDkqv3sygm5YyK8Gi4ShZqbhK2gxcs2U'

assert jwt.decode(encoded, key, algorithms="HS256") == {'some': 'payload'}