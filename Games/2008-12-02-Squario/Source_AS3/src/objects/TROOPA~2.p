
program 
  statementlist 
    package 
      packagename 
        packageidentifiers 
          identifier objects
    import  
      packagename 
        packageidentifiers 
          identifier flash
          identifier display
          identifier *
    class 
      attributelist 
        list 
          member 
            get lexical 
              identifier public
      qualifiedidentifier TroopaGreen 
        qualifier 
          attributelist 
            list 
              member 
                get lexical 
                  identifier public
      member 
        get lexical 
          identifier Enemy
      statementlist 
        var 
          attributelist 
            list 
              member 
                get lexical 
                  identifier private 
          list 
            variablebinding 
              typedidentifier 
                qualifiedidentifier Mode 
                  qualifier 
                    attributelist 
                      list 
                        member 
                          get lexical 
                            identifier private
                member 
                  get lexical 
                    identifier uint
              literalnumber:0
        function 
          attributelist 
            list 
              member 
                get lexical 
                  identifier public
          functionname 
            qualifiedidentifier TroopaGreen 
              qualifier 
                attributelist 
                  list 
                    member 
                      get lexical 
                        identifier public
          functioncommon 
            functionsignature 
              parameterlist 
                parameter 
                  identifier Xpos
                  member 
                    get lexical 
                      identifier uint
                parameter 
                  identifier Ypos
                  member 
                    get lexical 
                      identifier uint
            statementlist 
              expression 
                list 
                  member 
                    set lexical 
                      identifier eX
                      argumentlist 
                        member 
                          get lexical 
                            identifier Xpos
              expression 
                list 
                  member 
                    set lexical 
                      identifier eY
                      argumentlist 
                        member 
                          get lexical 
                            identifier Ypos
              expression 
                list 
                  member 
                    set lexical 
                      identifier eWid
                      argumentlist 
                        literalnumber:14
              expression 
                list 
                  member 
                    set lexical 
                      identifier dir
                      argumentlist 
                        member 
                          member 
                            get lexical 
                              identifier Mario
                          call dot 
                            identifier Sign
                            argumentlist 
                              binary minus 
                                member 
                                  member 
                                    get lexical 
                                      identifier Player
                                  get dot 
                                    identifier pX
                                member 
                                  get lexical 
                                    identifier eX
              expression 
                list 
                  member 
                    set lexical 
                      identifier eHei
                      argumentlist 
                        literalnumber:15
              var  
                list 
                  variablebinding 
                    typedidentifier 
                      qualifiedidentifier GFXclass
                      member 
                        get lexical 
                          identifier Class
                    member 
                      member 
                        member 
                          get lexical 
                            identifier Mario
                        get dot 
                          identifier classGFX
                      call dot 
                        identifier AccessGFX
                        argumentlist 
                          literalstring:enemy_koopa_green
              expression 
                list 
                  member 
                    set lexical 
                      identifier GFX
                      argumentlist 
                        member 
                          construct lexical 
                            identifier GFXclass
              expression 
                list 
                  member 
                    member 
                      get lexical 
                        identifier GFX
                    set dot 
                      identifier x
                      argumentlist 
                        binary minus 
                          member 
                            get lexical 
                              identifier eX
                          literalnumber:3
              expression 
                list 
                  member 
                    member 
                      get lexical 
                        identifier GFX
                    set dot 
                      identifier y
                      argumentlist 
                        binary minus 
                          member 
                            get lexical 
                              identifier eY
                          literalnumber:5
              expression 
                list 
                  member 
                    member 
                      member 
                        get lexical 
                          identifier Mario
                      get dot 
                        identifier layerFore
                    call dot 
                      identifier addChild
                      argumentlist 
                        member 
                          get lexical 
                            identifier GFX
              return 
        function 
          attributelist 
            identifier public
            list 
              member 
                get lexical 
                  identifier override
          functionname 
            qualifiedidentifier Update 
              qualifier 
                attributelist 
                  identifier public
                  list 
                    member 
                      get lexical 
                        identifier override
          functioncommon 
            functionsignature 
              parameterlist 
                parameter 
                  identifier myID
                  member 
                    get lexical 
                      identifier uint
            statementlist 
              if 
                list 
                  member 
                    get lexical 
                      identifier active 
                statementlist 
                  if 
                    list 
                      binary equals 
                        member 
                          get lexical 
                            identifier Mode
                        literalnumber:0 
                    statementlist 
                      expression 
                        list 
                          member 
                            set lexical 
                              identifier eX
                              argumentlist 
                                binary plus 
                                  member 
                                    get lexical 
                                      identifier eX
                                  member 
                                    get lexical 
                                      identifier dir
                      if 
                        list 
                          binary greaterthan 
                            member 
                              get lexical 
                                identifier dir
                            literalnumber:0 
                        statementlist 
                          if 
                            list 
                              binary equals 
                                member 
                                  member 
                                    get lexical 
                                      identifier Mario
                                  call dot 
                                    identifier enemyBounce
                                    argumentlist 
                                      member 
                                        get lexical 
                                          identifier myID
                                      binary minus 
                                        binary plus 
                                          member 
                                            get lexical 
                                              identifier eX
                                          member 
                                            get lexical 
                                              identifier eWid
                                        literalnumber:1
                                      member 
                                        get lexical 
                                          identifier eY
                                      literalnumber:2
                                      member 
                                        get lexical 
                                          identifier eHei
                                literalboolean 0 
                            statementlist 
                              if 
                                list 
                                  binary logicalor 
                                    member 
                                      member 
                                        get lexical 
                                          identifier Mario
                                      call dot 
                                        identifier levelColl
                                        argumentlist 
                                          binary minus 
                                            binary plus 
                                              member 
                                                get lexical 
                                                  identifier eX
                                              member 
                                                get lexical 
                                                  identifier eWid
                                            literalnumber:1
                                          member 
                                            get lexical 
                                              identifier eY
                                    member 
                                      member 
                                        get lexical 
                                          identifier Mario
                                      call dot 
                                        identifier levelColl
                                        argumentlist 
                                          binary minus 
                                            binary plus 
                                              member 
                                                get lexical 
                                                  identifier eX
                                              member 
                                                get lexical 
                                                  identifier eWid
                                            literalnumber:1
                                          binary minus 
                                            binary plus 
                                              member 
                                                get lexical 
                                                  identifier eY
                                              member 
                                                get lexical 
                                                  identifier eHei
                                            literalnumber:1 
                                statementlist 
                                  expression 
                                    list 
                                      member 
                                        set lexical 
                                          identifier dir
                                          argumentlist 
                                            binary mult 
                                              member 
                                                get lexical 
                                                  identifier dir
                                              literalnumber:-1
                                  expression 
                                    list 
                                      member 
                                        set lexical 
                                          identifier eX
                                          argumentlist 
                                            binary plus 
                                              member 
                                                get lexical 
                                                  identifier eX
                                              member 
                                                get lexical 
                                                  identifier dir  
                            statementlist 
                              expression 
                                list 
                                  member 
                                    set lexical 
                                      identifier dir
                                      argumentlist 
                                        binary mult 
                                          member 
                                            get lexical 
                                              identifier dir
                                          literalnumber:-1
                              expression 
                                list 
                                  member 
                                    set lexical 
                                      identifier eX
                                      argumentlist 
                                        binary plus 
                                          member 
                                            get lexical 
                                              identifier eX
                                          member 
                                            get lexical 
                                              identifier dir 
                        statementlist 
                          if 
                            list 
                              binary equals 
                                member 
                                  member 
                                    get lexical 
                                      identifier Mario
                                  call dot 
                                    identifier enemyBounce
                                    argumentlist 
                                      member 
                                        get lexical 
                                          identifier myID
                                      member 
                                        get lexical 
                                          identifier eX
                                      member 
                                        get lexical 
                                          identifier eY
                                      literalnumber:2
                                      member 
                                        get lexical 
                                          identifier eHei
                                literalboolean 0 
                            statementlist 
                              if 
                                list 
                                  binary logicalor 
                                    member 
                                      member 
                                        get lexical 
                                          identifier Mario
                                      call dot 
                                        identifier levelColl
                                        argumentlist 
                                          member 
                                            get lexical 
                                              identifier eX
                                          member 
                                            get lexical 
                                              identifier eY
                                    member 
                                      member 
                                        get lexical 
                                          identifier Mario
                                      call dot 
                                        identifier levelColl
                                        argumentlist 
                                          member 
                                            get lexical 
                                              identifier eX
                                          binary minus 
                                            binary plus 
                                              member 
                                                get lexical 
                                                  identifier eY
                                              member 
                                                get lexical 
                                                  identifier eHei
                                            literalnumber:1 
                                statementlist 
                                  expression 
                                    list 
                                      member 
                                        set lexical 
                                          identifier dir
                                          argumentlist 
                                            binary mult 
                                              member 
                                                get lexical 
                                                  identifier dir
                                              literalnumber:-1
                                  expression 
                                    list 
                                      member 
                                        set lexical 
                                          identifier eX
                                          argumentlist 
                                            binary plus 
                                              member 
                                                get lexical 
                                                  identifier eX
                                              member 
                                                get lexical 
                                                  identifier dir  
                            statementlist 
                              expression 
                                list 
                                  member 
                                    set lexical 
                                      identifier dir
                                      argumentlist 
                                        binary mult 
                                          member 
                                            get lexical 
                                              identifier dir
                                          literalnumber:-1
                              expression 
                                list 
                                  member 
                                    set lexical 
                                      identifier eX
                                      argumentlist 
                                        binary plus 
                                          member 
                                            get lexical 
                                              identifier eX
                                          member 
                                            get lexical 
                                              identifier dir
                      expression 
                        list 
                          member 
                            set lexical 
                              identifier gravity
                              argumentlist 
                                binary plus 
                                  member 
                                    get lexical 
                                      identifier gravity
                                  member 
                                    member 
                                      get lexical 
                                        identifier Mario
                                    get dot 
                                      identifier gravity
                      if 
                        list 
                          binary greaterthan 
                            member 
                              get lexical 
                                identifier gravity
                            literalnumber:10 
                        statementlist 
                          expression 
                            list 
                              member 
                                set lexical 
                                  identifier gravity
                                  argumentlist 
                                    literalnumber:10 
                      expression 
                        list 
                          member 
                            set lexical 
                              identifier eY
                              argumentlist 
                                binary plus 
                                  member 
                                    get lexical 
                                      identifier eY
                                  member 
                                    member 
                                      get lexical 
                                        identifier Math
                                    call dot 
                                      identifier round
                                      argumentlist 
                                        member 
                                          get lexical 
                                            identifier gravity
                      if 
                        list 
                          binary greaterthan 
                            member 
                              get lexical 
                                identifier gravity
                            literalnumber:0 
                        statementlist 
                          if 
                            list 
                              binary logicalor 
                                member 
                                  member 
                                    get lexical 
                                      identifier Mario
                                  call dot 
                                    identifier levelColl
                                    argumentlist 
                                      member 
                                        get lexical 
                                          identifier eX
                                      binary minus 
                                        binary plus 
                                          member 
                                            get lexical 
                                              identifier eY
                                          member 
                                            get lexical 
                                              identifier eHei
                                        literalnumber:1
                                member 
                                  member 
                                    get lexical 
                                      identifier Mario
                                  call dot 
                                    identifier levelColl
                                    argumentlist 
                                      binary minus 
                                        binary plus 
                                          member 
                                            get lexical 
                                              identifier eX
                                          member 
                                            get lexical 
                                              identifier eWid
                                        literalnumber:1
                                      binary minus 
                                        binary plus 
                                          member 
                                            get lexical 
                                              identifier eY
                                          member 
                                            get lexical 
                                              identifier eHei
                                        literalnumber:1 
                            statementlist 
                              expression 
                                list 
                                  member 
                                    set lexical 
                                      identifier gravity
                                      argumentlist 
                                        literalnumber:0
                              expression 
                                list 
                                  member 
                                    set lexical 
                                      identifier eY
                                      argumentlist 
                                        binary plus 
                                          binary mult 
                                            member 
                                              member 
                                                get lexical 
                                                  identifier Math
                                              call dot 
                                                identifier floor
                                                argumentlist 
                                                  binary div 
                                                    member 
                                                      get lexical 
                                                        identifier eY
                                                    literalnumber:25
                                            literalnumber:25
                                          literalnumber:10  
                      if 
                        list 
                          member 
                            member 
                              get lexical 
                                identifier Mario
                            call dot 
                              identifier Collide
                              argumentlist 
                                member 
                                  get lexical 
                                    identifier eX
                                member 
                                  get lexical 
                                    identifier eY
                                member 
                                  get lexical 
                                    identifier eWid
                                member 
                                  get lexical 
                                    identifier eHei
                                member 
                                  member 
                                    get lexical 
                                      identifier Player
                                  get dot 
                                    identifier pX
                                member 
                                  member 
                                    get lexical 
                                      identifier Player
                                  get dot 
                                    identifier pY
                                member 
                                  member 
                                    get lexical 
                                      identifier Player
                                  get dot 
                                    identifier pWid
                                member 
                                  member 
                                    get lexical 
                                      identifier Player
                                  get dot 
                                    identifier pHei 
                        statementlist 
                          if 
                            list 
                              member 
                                member 
                                  get lexical 
                                    identifier Player
                                call dot 
                                  identifier Falls 
                            statementlist 
                              if 
                                list 
                                  binary equals 
                                    member 
                                      member 
                                        get lexical 
                                          identifier Player
                                      get dot 
                                        identifier hitStomp
                                    literalboolean 0 
                                statementlist 
                                  expression 
                                    list 
                                      member 
                                        member 
                                          get lexical 
                                            identifier Player
                                        set dot 
                                          identifier hitStomp
                                          argumentlist 
                                            literalboolean 1
                                  expression 
                                    list 
                                      member 
                                        member 
                                          get lexical 
                                            identifier Player
                                        call dot 
                                          identifier Bounce
                                          argumentlist 
                                            member 
                                              get lexical 
                                                identifier eY
                                  expression 
                                    list 
                                      member 
                                        member 
                                          member 
                                            get lexical 
                                              identifier Mario
                                          get dot 
                                            identifier layerFore
                                        call dot 
                                          identifier removeChild
                                          argumentlist 
                                            member 
                                              get lexical 
                                                identifier GFX
                                  expression 
                                    list 
                                      member 
                                        member 
                                          get lexical 
                                            identifier Mario
                                        call dot 
                                          identifier removeEnemy
                                          argumentlist 
                                            member 
                                              get lexical 
                                                identifier myID  
                            statementlist 
                              expression 
                                list 
                                  member 
                                    member 
                                      get lexical 
                                        identifier Mario
                                    call dot 
                                      identifier hitPlayer 
                      expression 
                        list 
                          member 
                            member 
                              get lexical 
                                identifier GFX
                            set dot 
                              identifier x
                              argumentlist 
                                binary minus 
                                  member 
                                    get lexical 
                                      identifier eX
                                  literalnumber:3
                      expression 
                        list 
                          member 
                            member 
                              get lexical 
                                identifier GFX
                            set dot 
                              identifier y
                              argumentlist 
                                binary minus 
                                  member 
                                    get lexical 
                                      identifier eY
                                  literalnumber:15 
                    statementlist 
                      if 
                        list 
                          binary equals 
                            member 
                              get lexical 
                                identifier Mode
                            literalnumber:1 
                        statementlist 
                          expression 
                            list 
                              member 
                                set lexical 
                                  identifier gravity
                                  argumentlist 
                                    binary plus 
                                      member 
                                        get lexical 
                                          identifier gravity
                                      member 
                                        member 
                                          get lexical 
                                            identifier Mario
                                        get dot 
                                          identifier gravity
                          if 
                            list 
                              binary greaterthan 
                                member 
                                  get lexical 
                                    identifier gravity
                                literalnumber:10 
                            statementlist 
                              expression 
                                list 
                                  member 
                                    set lexical 
                                      identifier gravity
                                      argumentlist 
                                        literalnumber:10 
                          expression 
                            list 
                              member 
                                set lexical 
                                  identifier eY
                                  argumentlist 
                                    binary plus 
                                      member 
                                        get lexical 
                                          identifier eY
                                      member 
                                        member 
                                          get lexical 
                                            identifier Math
                                        call dot 
                                          identifier round
                                          argumentlist 
                                            member 
                                              get lexical 
                                                identifier gravity
                          if 
                            list 
                              binary greaterthan 
                                member 
                                  get lexical 
                                    identifier gravity
                                literalnumber:0 
                            statementlist 
                              if 
                                list 
                                  binary logicalor 
                                    member 
                                      member 
                                        get lexical 
                                          identifier Mario
                                      call dot 
                                        identifier levelColl
                                        argumentlist 
                                          member 
                                            get lexical 
                                              identifier eX
                                          binary minus 
                                            binary plus 
                                              member 
                                                get lexical 
                                                  identifier eY
                                              member 
                                                get lexical 
                                                  identifier eHei
                                            literalnumber:1
                                    member 
                                      member 
                                        get lexical 
                                          identifier Mario
                                      call dot 
                                        identifier levelColl
                                        argumentlist 
                                          binary minus 
                                            binary plus 
                                              member 
                                                get lexical 
                                                  identifier eX
                                              member 
                                                get lexical 
                                                  identifier eWid
                                            literalnumber:1
                                          binary minus 
                                            binary plus 
                                              member 
                                                get lexical 
                                                  identifier eY
                                              member 
                                                get lexical 
                                                  identifier eHei
                                            literalnumber:1 
                                statementlist 
                                  expression 
                                    list 
                                      member 
                                        set lexical 
                                          identifier gravity
                                          argumentlist 
                                            literalnumber:0
                                  expression 
                                    list 
                                      member 
                                        set lexical 
                                          identifier eY
                                          argumentlist 
                                            binary plus 
                                              binary mult 
                                                member 
                                                  member 
                                                    get lexical 
                                                      identifier Math
                                                  call dot 
                                                    identifier floor
                                                    argumentlist 
                                                      binary div 
                                                        member 
                                                          get lexical 
                                                            identifier eY
                                                        literalnumber:25
                                                literalnumber:25
                                              literalnumber:10  
                          if 
                            list 
                              binary logicaland 
                                binary equals 
                                  member 
                                    member 
                                      get lexical 
                                        identifier Player
                                    get dot 
                                      identifier hitStomp
                                  literalboolean 0
                                member 
                                  member 
                                    get lexical 
                                      identifier Mario
                                  call dot 
                                    identifier Collide
                                    argumentlist 
                                      member 
                                        get lexical 
                                          identifier eX
                                      member 
                                        get lexical 
                                          identifier eY
                                      member 
                                        get lexical 
                                          identifier eWid
                                      member 
                                        get lexical 
                                          identifier eHei
                                      member 
                                        member 
                                          get lexical 
                                            identifier Player
                                        get dot 
                                          identifier pX
                                      member 
                                        member 
                                          get lexical 
                                            identifier Player
                                        get dot 
                                          identifier pY
                                      member 
                                        member 
                                          get lexical 
                                            identifier Player
                                        get dot 
                                          identifier pWid
                                      member 
                                        member 
                                          get lexical 
                                            identifier Player
                                        get dot 
                                          identifier pHei 
                            statementlist 
                              if 
                                list 
                                  binary greaterthan 
                                    binary minus 
                                      member 
                                        member 
                                          get lexical 
                                            identifier Player
                                        get dot 
                                          identifier pX
                                      member 
                                        get lexical 
                                          identifier eY
                                    literalnumber:7 
                                statementlist 
                                  expression 
                                    list 
                                      member 
                                        set lexical 
                                          identifier dir
                                          argumentlist 
                                            literalnumber:-1 
                                statementlist 
                                  expression 
                                    list 
                                      member 
                                        set lexical 
                                          identifier dir
                                          argumentlist 
                                            literalnumber:1
                              expression 
                                list 
                                  member 
                                    set lexical 
                                      identifier isShell
                                      argumentlist 
                                        literalboolean 1
                              expression 
                                list 
                                  member 
                                    set lexical 
                                      identifier Mode
                                      argumentlist 
                                        literalnumber:2 
                          expression 
                            list 
                              member 
                                member 
                                  get lexical 
                                    identifier GFX
                                set dot 
                                  identifier x
                                  argumentlist 
                                    binary minus 
                                      member 
                                        get lexical 
                                          identifier eX
                                      literalnumber:3
                          expression 
                            list 
                              member 
                                member 
                                  get lexical 
                                    identifier GFX
                                set dot 
                                  identifier y
                                  argumentlist 
                                    binary minus 
                                      member 
                                        get lexical 
                                          identifier eY
                                      literalnumber:5  
                statementlist 
                  expression 
                    list 
                      member 
                        set lexical 
                          identifier active
                          argumentlist 
                            literalboolean 1
              return 
        function 
          attributelist 
            list 
              member 
                get lexical 
                  identifier private
          functionname 
            qualifiedidentifier makeShell 
              qualifier 
                attributelist 
                  list 
                    member 
                      get lexical 
                        identifier private
          functioncommon 
            functionsignature 
            statementlist 
              var  
                list 
                  variablebinding 
                    typedidentifier 
                      qualifiedidentifier GFXclass
                      member 
                        get lexical 
                          identifier Class
                    member 
                      member 
                        member 
                          get lexical 
                            identifier Mario
                        get dot 
                          identifier classGFX
                      call dot 
                        identifier AccessGFX
                        argumentlist 
                          literalstring:enemy_shell_green
              expression 
                list 
                  member 
                    set lexical 
                      identifier GFX
                      argumentlist 
                        member 
                          construct lexical 
                            identifier GFXclass
              expression 
                list 
                  member 
                    member 
                      get lexical 
                        identifier GFX
                    set dot 
                      identifier x
                      argumentlist 
                        binary minus 
                          member 
                            get lexical 
                              identifier eX
                          literalnumber:3
              expression 
                list 
                  member 
                    member 
                      get lexical 
                        identifier GFX
                    set dot 
                      identifier y
                      argumentlist 
                        binary minus 
                          member 
                            get lexical 
                              identifier eY
                          literalnumber:5
              expression 
                list 
                  member 
                    member 
                      member 
                        get lexical 
                          identifier Mario
                      get dot 
                        identifier layerFore
                    call dot 
                      identifier addChild
                      argumentlist 
                        member 
                          get lexical 
                            identifier GFX
              return 
    package 
      packagename 
        packageidentifiers 
          identifier objects
