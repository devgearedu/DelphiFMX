object ServerMethods1: TServerMethods1
  OldCreateOrder = False
  Height = 280
  Width = 402
  object FDConnection1: TFDConnection
    Params.Strings = (
      'ConnectionDef=sample')
    Connected = True
    LoginPrompt = False
    Left = 48
    Top = 32
  end
  object FDPhysIBDriverLink1: TFDPhysIBDriverLink
    Left = 120
    Top = 32
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 192
    Top = 32
  end
  object dept: TFDTable
    Connection = FDConnection1
    UpdateOptions.UpdateTableName = 'DEPT'
    TableName = 'DEPT'
    Left = 40
    Top = 136
  end
  object deptProvider: TDataSetProvider
    DataSet = dept
    Left = 80
    Top = 136
  end
  object InsaQuery: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      ' select * from insa'
      ' where dept_code =:code')
    Left = 256
    Top = 128
    ParamData = <
      item
        Name = 'CODE'
        ParamType = ptInput
      end>
  end
  object InsaQuertyProvider: TDataSetProvider
    DataSet = InsaQuery
    Left = 296
    Top = 128
  end
  object totQuery: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select count(id) as total'
      'from insa'
      'where dept_code like :code')
    Left = 168
    Top = 136
    ParamData = <
      item
        Name = 'CODE'
        ParamType = ptInput
      end>
  end
end
