--Damage
GLOBALDAMAGE = 7.5

--Health
GLOBALHEALTH = 20

-- Biter configuration
biter = {
    scale = {
        small = 0.5,
        medium = 0.8,
        big = 1.2,
        behemoth = 1.7,
        boss = 4.5
    },
    damage = {
        small = GLOBALDAMAGE * 1,
        medium = GLOBALDAMAGE * 2,
        big = GLOBALDAMAGE * 4,
        behemoth = GLOBALDAMAGE * 12,
        boss = GLOBALDAMAGE * 175
    },
    health = {
        small = GLOBALHEALTH * 1,
        medium = GLOBALHEALTH * 5,
        big = GLOBALHEALTH * 25,
        behemoth = GLOBALHEALTH * 200,
        boss = GLOBALHEALTH * 5000
    },
    colors = {
        primary = {
            biter = {r = 0, g = 0, b = 0, a = 1},
            laser = {r = 0, g = 0, b = 1, a = 1},
            physical = {r = 1, g = 1, b = 1, a = 1},
            impact = {r = 0.25, g = 0.20, b = 0.15, a = 1}  -- Dark brown/black
        },
        secondary = {
            secondColor = {r = 0, g = 0, b = 0, a = 1},
            secondColor2 = {r = 1, g = 1, b = 1, a = 1}
        }
    },
    resistances = {
        laser = {
            spawner = {
                {
                    type = "laser",
                    percent = 95
                },
                {
                    type = "explosion",
                    decrease = 5,
                    percent = 15
                },
                {
                    type = "fire",
                    decrease = 3,
                    percent = 60
                }
            },
            small = {
                {
                    type = "laser",
                    percent = 90
                }
            },
            medium = {
                {
                    type = "laser",
                    percent = 92
                },
                {
                    type = "explosion",
                    percent = 10
                }
            },
            big = {
                {
                    type = "laser",
                    percent = 94
                },
                {
                    type = "explosion",
                    percent = 10
                }
            },
            behemoth = {
                {
                    type = "laser",
                    percent = 96
                },
                {
                    type = "explosion",
                    decrease = 12,
                    percent = 10
                }
            },
            boss = {
                {
                    type = "laser",
                    percent = 90
                },
                {
                    type = "explosion",
                    decrease = 16,
                    percent = 10
                }
            }
        },
        physical = {
            spawner = {
                {
                    type = "physical",
                    percent = 95
                },
                {
                    type = "explosion",
                    decrease = 5,
                    percent = 15
                },
                {
                    type = "fire",
                    decrease = 3,
                    percent = 60
                }
            },
            small = {
                {
                    type = "physical",
                    percent = 90
                }
            },
            medium = {
                {
                    type = "physical",
                    percent = 92
                },
                {
                    type = "explosion",
                    percent = 10
                }
            },
            big = {
                {
                    type = "physical",
                    percent = 94
                },
                {
                    type = "explosion",
                    percent = 10
                }
            },
            behemoth = {
                {
                    type = "physical",
                    percent = 96
                },
                {
                    type = "explosion",
                    decrease = 12,
                    percent = 10
                }
            },
            boss = {
                {
                    type = "physical",
                    percent = 90
                },
                {
                    type = "explosion",
                    decrease = 16,
                    percent = 10
                }
            }
        },
        impact = {
            spawner = {
                {
                    type = "impact",
                    percent = 95
                },
                {
                    type = "physical",
                    decrease = 5,
                    percent = 50
                },
                {
                    type = "explosion",
                    decrease = 5,
                    percent = 15
                },
                {
                    type = "fire",
                    decrease = 3,
                    percent = 60
                }
            },
            small = {
                {
                    type = "impact",
                    percent = 80
                },
                {
                    type = "physical",
                    percent = 40
                }
            },
            medium = {
                {
                    type = "impact",
                    percent = 85
                },
                {
                    type = "physical",
                    percent = 50
                },
                {
                    type = "explosion",
                    percent = 10
                }
            },
            big = {
                {
                    type = "impact",
                    percent = 88
                },
                {
                    type = "physical",
                    percent = 55
                },
                {
                    type = "explosion",
                    percent = 10
                }
            },
            behemoth = {
                {
                    type = "impact",
                    percent = 92
                },
                {
                    type = "physical",
                    percent = 60
                },
                {
                    type = "explosion",
                    decrease = 12,
                    percent = 10
                }
            },
            boss = {
                {
                    type = "impact",
                    percent = 90
                },
                {
                    type = "physical",
                    percent = 55
                },
                {
                    type = "explosion",
                    decrease = 16,
                    percent = 10
                }
            }
        },
        basic = {
            spawner = {
                {
                    type = "physical",
                    decrease = 2,
                    percent = 15
                },
                {
                    type = "explosion",
                    decrease = 5,
                    percent = 15
                },
                {
                    type = "fire",
                    decrease = 3,
                    percent = 60
                }
            },
            small = {},
            medium = {
                {
                    type = "physical",
                    decrease = 4,
                    percent = 10
                },
                {
                    type = "explosion",
                    percent = 10
                }
            },
            big = {
                {
                    type = "physical",
                    decrease = 8,
                    percent = 10
                },
                {
                    type = "explosion",
                    percent = 10
                }
            },
            behemoth = {
                {
                    type = "physical",
                    decrease = 12,
                    percent = 10
                },
                {
                    type = "explosion",
                    decrease = 12,
                    percent = 10
                }
            },
            boss = {
                {
                    type = "physical",
                    decrease = 16,
                    percent = 10
                },
                {
                    type = "explosion",
                    decrease = 16,
                    percent = 10
                }
            }
        }
    }
}

-- Spitter configuration
spitter = {
    scale = {
        small = 0.5,
        medium = 0.8,
        big = 1.2,
        behemoth = 1.7,
        boss = 4.5
    },
    damage = {
        small = GLOBALDAMAGE * 2,
        medium = GLOBALDAMAGE * 3,
        big = GLOBALDAMAGE * 4,
        behemoth = GLOBALDAMAGE * 5,
        boss = GLOBALDAMAGE * 150
    },
    health = {
        small = GLOBALHEALTH * 1 / 2,
        medium = GLOBALHEALTH * 5 / 2,
        big = GLOBALHEALTH * 25 / 2,
        behemoth = GLOBALHEALTH * 200 / 2,
        boss = GLOBALHEALTH * 5000 / 2
    },
    range = {
        small = 10,
        medium = 15,
        big = 20,
        behemoth = 25,
        boss = 30
    },
    colors = {
        primary = {
            spitter = {r = 0.68, g = 0.4, b = 0, a = 1},
            fire = {r = 0.1, g = 1, b = 0.1, a = 1},
            explosive = {r = 1, g = 0, b = 0, a = 1},
            rocket = {r = 1, g = 0, b = 1, a = 1},
            poison = {r = 0.2, g = 0.8, b = 0.1, a = 1},    -- Toxic green
            electric = {r = 0.1, g = 0.9, b = 1, a = 1}     -- Cyan/electric blue
        },
        secondary = {
            secondColor = {r = 0, g = 0, b = 0, a = 1},
            secondColor2 = {r = 1, g = 1, b = 1, a = 1}
        }
    },
    resistances = {
        laser = {
            spawner = {
                {
                    type = "laser",
                    percent = 95
                },
                {
                    type = "explosion",
                    decrease = 5,
                    percent = 15
                },
                {
                    type = "fire",
                    decrease = 3,
                    percent = 60
                }
            },
            small = {
                {
                    type = "laser",
                    percent = 90
                }
            },
            medium = {
                {
                    type = "laser",
                    percent = 92
                },
                {
                    type = "explosion",
                    percent = 10
                }
            },
            big = {
                {
                    type = "laser",
                    percent = 94
                },
                {
                    type = "explosion",
                    percent = 10
                }
            },
            behemoth = {
                {
                    type = "laser",
                    percent = 96
                },
                {
                    type = "explosion",
                    decrease = 12,
                    percent = 10
                }
            },
            boss = {
                {
                    type = "laser",
                    percent = 98
                },
                {
                    type = "explosion",
                    decrease = 16,
                    percent = 10
                }
            }
        },
        physical = {
            spawner = {
                {
                    type = "physical",
                    percent = 95
                },
                {
                    type = "explosion",
                    decrease = 5,
                    percent = 15
                },
                {
                    type = "fire",
                    decrease = 3,
                    percent = 60
                }
            },
            small = {
                {
                    type = "physical",
                    percent = 90
                }
            },
            medium = {
                {
                    type = "physical",
                    percent = 92
                },
                {
                    type = "explosion",
                    percent = 10
                }
            },
            big = {
                {
                    type = "physical",
                    percent = 94
                },
                {
                    type = "explosion",
                    percent = 10
                }
            },
            behemoth = {
                {
                    type = "physical",
                    percent = 96
                },
                {
                    type = "explosion",
                    decrease = 12,
                    percent = 10
                }
            },
            boss = {
                {
                    type = "physical",
                    percent = 98
                },
                {
                    type = "explosion",
                    decrease = 16,
                    percent = 10
                }
            }
        },
        basic = {
            spawner = {
                {
                    type = "physical",
                    decrease = 2,
                    percent = 15
                },
                {
                    type = "explosion",
                    decrease = 5,
                    percent = 15
                },
                {
                    type = "fire",
                    decrease = 3,
                    percent = 60
                }
            },
            small = {},
            medium = {
                {
                    type = "explosion",
                    percent = 10
                }
            },
            big = {
                {
                    type = "explosion",
                    percent = 15
                }
            },
            behemoth = {
                {
                    type = "explosion",
                    percent = 30
                }
            },
            boss = {
                {
                    type = "explosion",
                    percent = 40
                }
            }
        },
        poison = {
            spawner = {
                {
                    type = "poison",
                    percent = 95
                },
                {
                    type = "explosion",
                    decrease = 5,
                    percent = 15
                },
                {
                    type = "fire",
                    decrease = 3,
                    percent = 60
                }
            },
            small = {
                {
                    type = "poison",
                    percent = 90
                }
            },
            medium = {
                {
                    type = "poison",
                    percent = 92
                },
                {
                    type = "explosion",
                    percent = 10
                }
            },
            big = {
                {
                    type = "poison",
                    percent = 94
                },
                {
                    type = "explosion",
                    percent = 10
                }
            },
            behemoth = {
                {
                    type = "poison",
                    percent = 96
                },
                {
                    type = "explosion",
                    decrease = 12,
                    percent = 10
                }
            },
            boss = {
                {
                    type = "poison",
                    percent = 98
                },
                {
                    type = "explosion",
                    decrease = 16,
                    percent = 10
                }
            }
        },
        electric = {
            spawner = {
                {
                    type = "electric",
                    percent = 95
                },
                {
                    type = "explosion",
                    decrease = 5,
                    percent = 15
                },
                {
                    type = "fire",
                    decrease = 3,
                    percent = 60
                }
            },
            small = {
                {
                    type = "electric",
                    percent = 90
                }
            },
            medium = {
                {
                    type = "electric",
                    percent = 92
                },
                {
                    type = "explosion",
                    percent = 10
                }
            },
            big = {
                {
                    type = "electric",
                    percent = 94
                },
                {
                    type = "explosion",
                    percent = 10
                }
            },
            behemoth = {
                {
                    type = "electric",
                    percent = 96
                },
                {
                    type = "explosion",
                    decrease = 12,
                    percent = 10
                }
            },
            boss = {
                {
                    type = "electric",
                    percent = 98
                },
                {
                    type = "explosion",
                    decrease = 16,
                    percent = 10
                }
            }
        }
    }
}

-- Spawner ratings for evolution factor
spawnerRating = {
    biter = {
        basic = {
            small = {{0.0, 0.3}, {0.7, 0.0}},
            medium = {{0.2, 0.0}, {0.6, 0.3}, {0.8, 0.1}},
            big = {{0.4, 0.0}, {1.0, 0.3}},
            behemoth = {{0.6, 0.0}, {1.0, 0.4}}
        },
        laser = {
            small = {{0.15, 0.8}, {0.6, 0.3}, {0.8, 0.1}},
            medium = {{0.4, 0.0}, {1.0, 0.3}},
            big = {{0.65, 0.0}, {1.0, 0.3}},
            behemoth = {{0.8, 0.0}, {1.0, 0.4}}
        },
        physical = {
            small = {{0.15, 0.8}, {0.6, 0.3}, {0.8, 0.1}},
            medium = {{0.4, 0.0}, {1.0, 0.3}},
            big = {{0.65, 0.0}, {1.0, 0.3}},
            behemoth = {{0.8, 0.0}, {1.0, 0.4}}
        },
        impact = {
            small = {{0.20, 0.8}, {0.6, 0.3}, {0.8, 0.1}},
            medium = {{0.45, 0.0}, {1.0, 0.3}},
            big = {{0.70, 0.0}, {1.0, 0.3}},
            behemoth = {{0.85, 0.0}, {1.0, 0.4}}
        }
    },
    spitter = {
        basic = {
            small = {{0.15, 0.3}, {0.7, 0.0}},
            medium = {{0.30, 0.0}, {0.6, 0.3}, {0.8, 0.1}},
            big = {{0.45, 0.0}, {1.0, 0.3}},
            behemoth = {{0.60, 0.0}, {1.0, 0.4}}
        },
        laser = {
            small = {{0.20, 0.3}, {0.7, 0.0}},
            medium = {{0.40, 0.0}, {0.6, 0.3}, {0.8, 0.1}},
            big = {{0.60, 0.0}, {1.0, 0.3}},
            behemoth = {{0.80, 0.0}, {1.0, 0.4}}
        },
        physical = {
            small = {{0.20, 0.3}, {0.7, 0.0}},
            medium = {{0.40, 0.0}, {0.6, 0.3}, {0.8, 0.1}},
            big = {{0.60, 0.0}, {1.0, 0.3}},
            behemoth = {{0.80, 0.0}, {1.0, 0.4}}
        },
        fire = {
            small = {{0.20, 0.3}, {0.7, 0.0}},
            medium = {{0.40, 0.0}, {0.6, 0.3}, {0.8, 0.1}},
            big = {{0.60, 0.0}, {1.0, 0.3}},
            behemoth = {{0.80, 0.0}, {1.0, 0.4}}
        },
        explosive = {
            small = {{0.25, 0.3}, {0.7, 0.0}},
            medium = {{0.45, 0.0}, {0.6, 0.3}, {0.8, 0.1}},
            big = {{0.65, 0.0}, {1.0, 0.3}},
            behemoth = {{0.85, 0.0}, {1.0, 0.4}}
        },
        rocket = {
            small = {{0.25, 0.3}, {0.7, 0.0}},
            medium = {{0.45, 0.0}, {0.6, 0.3}, {0.8, 0.1}},
            big = {{0.65, 0.0}, {1.0, 0.3}},
            behemoth = {{0.85, 0.0}, {1.0, 0.4}}
        },
        poison = {
            small = {{0.20, 0.3}, {0.7, 0.0}},
            medium = {{0.40, 0.0}, {0.6, 0.3}, {0.8, 0.1}},
            big = {{0.60, 0.0}, {1.0, 0.3}},
            behemoth = {{0.80, 0.0}, {1.0, 0.4}}
        },
        electric = {
            small = {{0.20, 0.3}, {0.7, 0.0}},
            medium = {{0.40, 0.0}, {0.6, 0.3}, {0.8, 0.1}},
            big = {{0.60, 0.0}, {1.0, 0.3}},
            behemoth = {{0.80, 0.0}, {1.0, 0.4}}
        }
    }
}
