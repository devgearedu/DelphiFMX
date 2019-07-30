unit FireBlazeEditors;

interface
uses
  SysUtils, System.UITypes, DesignIntf, DesignEditors;
Type
  TFileNameProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
  end;

  procedure Register;

implementation
uses
  FMX.Dialogs, FMX.Forms;

  function TFileNameProperty.GetAttributes: TPropertyAttributes;
  begin
    Result := [paDialog]
  end;

  procedure TFileNameProperty.Edit;
  begin
    with TOpenDialog.Create(Application) do
    try
      Title := 'Select SpriteSheet Image File';
      Filename := GetValue;
      Filter := 'All Files (*.*)|*.*';
      HelpContext := 0;
      if Execute then SetValue(Filename);
    finally
      Free
    end
  end;

  procedure Register;
  begin
    RegisterPropertyEditor(TypeInfo(TFileName),nil, '', TFileNameProperty)
  end;
end.

