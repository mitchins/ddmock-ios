# DD Mock

An API mocking library for iOS.

## Getting started

1. Drag `build/DDMockiOS/` into project root folder

2. Add run script to target build phase

`python ${SRCROOT}/DDMockiOS/init.py <path_to_mock_files>`

3. Add `DDMock.shared.initialise()` to AppDelegate

4. Add `DDMockProtocol.initialise(config: ...)` to networking library

e.g. 

```
let configuration = URLSessionConfiguration.default
// other configuration set up
DDMockProtocol.initialise(config: configuration)
```

## Mock API files

* All API mock files are stored under __/assets/mockfiles__ and are mapped based on the __endpoint path__ and __HTTP method__.
* e.g. login mock response file for endpoint __POST__ BASE_URL/__mobile-api/v1/auth/login__ should be stored under __mobile-api/v1/auth/login/post__
* For dynamic endpoint url, create directories with __{__ and __}__ for every replacement blocks and parameters
* e.g. mock files for __GET__ BASE_URL/__mobile-api/v1/users/{usersId}__ should be stored under __mobile-api/v1/users/{usersId}/get__
* see `sample`
* All mock files need to be JSON files
* There can be more than one mock file stored under each endpoint path
* By default, the first file listed (alphabetically ordered) under each endpoint path is selected as the mock response
