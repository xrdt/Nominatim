@APIDB
Feature: Reverse geocoding
    Testing the reverse function

    @Tiger
    Scenario: TIGER house number
        When sending jsonv2 reverse coordinates 45.3345,-97.5214
        Then results contain
          | osm_type | category | type |
          | way      | place    | house |
        And result addresses contain
          | house_number | road            | postcode | country_code |
          | 906          | West 1st Street | 57274    | us |

    @Tiger
    Scenario: No TIGER house number for zoom < 18
        When sending jsonv2 reverse coordinates 45.3345,-97.5214
          | zoom |
          | 17 |
        Then results contain
          | osm_type | category |
          | way      | highway  |
        And result addresses contain
          | road            | postcode | country_code |
          | West 1st Street | 57274    | us |

    Scenario: Interpolated house number
        When sending jsonv2 reverse coordinates -33.231795578514635,-54.38682173844428
        Then results contain
          | osm_type | category | type |
          | way      | place    | house |
        And result addresses contain
          | house_number | road |
          | 1410         | Juan Antonio Lavalleja |

    Scenario: Address with non-numerical house number
        When sending jsonv2 reverse coordinates 53.579805460944,9.9475670458196
        Then result addresses contain
          | house_number | road |
          | 43 Haus 4    | Stellinger Weg |


    Scenario: Address with numerical house number
        When sending jsonv2 reverse coordinates 53.580206752486,9.9502944945198
        Then result addresses contain
          | house_number | road |
          | 5            | Clasingstraße |

    Scenario: Location off the coast
        When sending jsonv2 reverse coordinates 54.046489113,8.5546870529
        Then results contain
         | display_name |
         | Freie und Hansestadt Hamburg, Deutschland |

    Scenario: When slightly outside town, the town is not shown
        When sending jsonv2 reverse coordinates -32.122,-56.114
         | zoom |
         | 15 |
        Then results contain
         | display_name |
         | Tacuarembó, Uruguay |

    Scenario Outline: Zoom levels below 5 result in country
        When sending jsonv2 reverse coordinates -33.28,-56.29
         | zoom |
         | <zoom> |
        Then results contain
         | display_name |
         | Uruguay |

    Examples:
         | zoom |
         | 0    |
         | 1    |
         | 2    |
         | 3    |
         | 4    |
