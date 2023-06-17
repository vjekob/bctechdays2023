page 50001 "Set API Secret"
{
    DataCaptionExpression = _caption;
    PageType = StandardDialog;

    layout
    {
        area(Content)
        {
            field(Secret; _secret)
            {
                Caption = 'Enter the value';
                ApplicationArea = All;
                ToolTip = 'Specifies the secret value.';
                ExtendedDatatype = Masked;
            }
        }
    }

    var
        _caption: Text;
        _secret: Text;


    procedure GetSecret(var Secret: Text; Caption: Text): Boolean
    begin
        _caption := Caption;
        if CurrPage.RunModal() <> Action::OK then
            exit(false);

        Secret := _secret;
        exit(true);
    end;
}
