codeunit 60100 "GetWeight New Meth"
{
    procedure GetWeight(var Item: Record Item);
    var
        Handled: Boolean;
    begin
        OnBeforeGetWeight(Item, Handled);

        DoGetWeight(Item, Handled);

        OnAfterGetWeight(Item);
    end;

    local procedure DoGetWeight(var Item: Record Item; var Handled: Boolean);
    var
        Scale: Interface IScale;
    begin
        if Handled then
            exit;

        Scale := GetScale();

        Item.validate(Weight, scale.GetWeight());
        Item.Modify(true);

        // if (scale.Getinfo() <> '') then
        //     message(scale.Getinfo());

    end;

    local procedure GetScale(): enum Scales
    var
        ScaleSetup: Record ScaleSetup;
    begin
        ScaleSetup.Get;
        exit(ScaleSetup.Scale);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeGetWeight(var Item: Record Item; var Handled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterGetWeight(var Item: Record Item);
    begin
    end;
}