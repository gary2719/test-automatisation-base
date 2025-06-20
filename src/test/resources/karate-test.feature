@HU-BTGSD-1 @ValidarEndpoints
Feature: Test de API personajes Marvel

  Background:
    * configure ssl = true
    * def urlTest = 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters'

  @id:1 @ObtenerTodosLosPersonajes
  Scenario: Obtener todos los personajes y validar el estado
    Given url urlTest
    When method get
    Then status 200

  @id:2 @ObtenerPersonajePorId
  Scenario: Verificar que se puede obtener un personaje por ID y validar el nombre
    Given url urlTest
    And path '212'
    When method get
    Then status 200
    And match response.name == 'Iron Man'

  @id:3 @ObtenerPersonajePorIdNoExiste
  Scenario: Verificar que un personaje no existente devuelve 404
    Given url urlTest
    And path '1000000'
    When method get
    Then status 404


  @id:4 @ActualizarPersonajePorId
  Scenario: Actualizar un personaje por ID y validar el nombre
    * def body = read('classpath:CharacterUpdateJson.json')
    Given url urlTest
    And path '212'
    And request body
    When method put
    Then status 200
    And match response.name == 'Iron Man'
    And match response.description == 'Updated description'


  @id:5 @ActualizarPersonajePorIdNoExiste
  Scenario: Actualizar personaje que no existe
    * def body = read('classpath:CharacterUpdateJson.json')
    Given url urlTest
    And path '10000000'
    And request body
    When method put
    Then status 404

  @id:6 @EliminarPersonajePorIdNoExiste
  Scenario: Eliminar un personaje por ID no existente
    Given url urlTest
    And path '1000000'
    When method delete
    Then status 404

  @id:6 @EliminarPersonajePorId
  Scenario: Eliminar un personaje por ID
    Given url urlTest
    And path '1193'
    When method delete
    Then status 204

  @id:7 @CrearPersonaje
  Scenario: Crear un personaje y validar que no se puede duplicar
    * def body = read('classpath:CharacterJson.json')
    Given url urlTest
    And request body
    When method post
    Then status 201
    And match response.name == 'Iron Maiden 6'

    Given url urlTest
    And request body
    When method post
    Then status 400

  @id:7 @CrearPersonajeDuplicado
  Scenario: Crear un personaje duplicado y capturar el error
    * def body = read('classpath:CharacterJson.json')
    Given url urlTest
    And request body
    When method post
    Then status 400
    And match response.error == 'Character name already exists'


