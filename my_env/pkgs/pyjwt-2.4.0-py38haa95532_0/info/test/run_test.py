#  tests for pyjwt-2.4.0-py38haa95532_0 (this is a generated file);
print('===== testing package: pyjwt-2.4.0-py38haa95532_0 =====');
print('running run_test.py');
#  --- run_test.py (begin) ---
import jwt


key = "secret"
encoded = jwt.encode({"some": "payload"}, key, algorithm="HS256")

assert encoded == 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzb21lIjoicGF5bG9hZCJ9.Joh1R2dYzkRvDkqv3sygm5YyK8Gi4ShZqbhK2gxcs2U'

assert jwt.decode(encoded, key, algorithms="HS256") == {'some': 'payload'}#  --- run_test.py (end) ---

print('===== pyjwt-2.4.0-py38haa95532_0 OK =====');
print("import: 'jwt'")
import jwt

