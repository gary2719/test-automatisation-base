@HU-BTGSD-1 @ValidarEndpoints
Feature: Test de API personajes Marvel

  Background:
    * configure ssl = true
    * def urlTest = 'http://bp-se-test-cabcd9b246a5.herokuapp.com/testuser/api/characters'

  @id:1 @ValidarRespuestaEndpointPublico
  Scenario: Verificar que un endpoint público responde 200
    Given url urlTest
    When method get
    Then status 200

  @id:2 @ObtenerPersonajePorId
  Scenario: Verificar que se puede obtener un personaje por ID y validar el nombre
    Given url urlTest
    And path '212'
    When method get
    Then status 200
    And match response.name == 'Iron Maiden 2'

  @id:3 @ObtenerPersonajePorIdNoExiste
  Scenario: Verificar que un personaje no existente devuelve 404
    Given url urlTest
    And path '1000000'
    When method get
    Then status 404




