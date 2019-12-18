object Form168: TForm168
  Left = 0
  Top = 0
  Caption = 'Form168'
  ClientHeight = 395
  ClientWidth = 589
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 8
    Top = 64
    Width = 577
    Height = 113
    DataSource = DataSource1
    Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DBNavigator1: TDBNavigator
    Left = 232
    Top = 16
    Width = 350
    Height = 42
    DataSource = DataSource1
    TabOrder = 1
  end
  object Button1: TButton
    Left = 8
    Top = 183
    Width = 75
    Height = 25
    Caption = 'cancelupdates'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 89
    Top = 183
    Width = 75
    Height = 25
    Caption = 'revertrecord'
    TabOrder = 3
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 170
    Top = 183
    Width = 75
    Height = 25
    Caption = 'applyupdates'
    TabOrder = 4
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 251
    Top = 183
    Width = 75
    Height = 25
    Caption = 'save'
    TabOrder = 5
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 332
    Top = 183
    Width = 75
    Height = 25
    Caption = 'load'
    TabOrder = 6
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 413
    Top = 183
    Width = 75
    Height = 25
    Caption = 'getcount'
    TabOrder = 7
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 494
    Top = 183
    Width = 75
    Height = 25
    Caption = 'echo'
    TabOrder = 8
    OnClick = Button7Click
  end
  object DBGrid2: TDBGrid
    Left = 8
    Top = 267
    Width = 561
    Height = 120
    DataSource = DataSource2
    Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 9
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object SQLConnection1: TSQLConnection
    DriverName = 'DataSnap'
    LoginPrompt = False
    Params.Strings = (
      'DriverUnit=Data.DBXDataSnap'
      'HostName=localhost'
      'Port=211'
      'CommunicationProtocol=tcp/ip'
      'DatasnapContext=datasnap/'
      
        'DriverAssemblyLoader=Borland.Data.TDBXClientDriverLoader,Borland' +
        '.Data.DbxClientDriver,Version=24.0.0.0,Culture=neutral,PublicKey' +
        'Token=91d62ebb5b0d1b1b'
      'Filters={}')
    Connected = True
    Left = 24
    Top = 16
    UniqueId = '{EE3C8B79-78EA-4E87-9BC6-6525DAAC00FB}'
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = ' TServerMethods1'
    Connected = True
    SQLConnection = SQLConnection1
    Left = 88
    Top = 16
  end
  object dept_cds: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    ProviderName = 'deptProvider'
    RemoteServer = DSProviderConnection1
    OnReconcileError = dept_cdsReconcileError
    Left = 144
    Top = 16
  end
  object DataSource1: TDataSource
    DataSet = dept_cds
    OnDataChange = DataSource1DataChange
    Left = 184
    Top = 24
  end
  object insaquery: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftUnknown
        Name = 'CODE'
        ParamType = ptInput
      end>
    ProviderName = 'InsaQuertyProvider'
    RemoteServer = DSProviderConnection1
    Left = 24
    Top = 224
  end
  object DataSource2: TDataSource
    DataSet = insaquery
    Left = 112
    Top = 224
  end
  object SqlServerMethod1: TSqlServerMethod
    Params = <
      item
        DataType = ftWideString
        Precision = 2000
        Name = 'Value'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Precision = 2000
        Name = 'ReturnParameter'
        ParamType = ptResult
        Size = 2000
      end>
    SQLConnection = SQLConnection1
    ServerMethodName = 'TServerMethods1.EchoString'
    Left = 528
    Top = 224
  end
end
