enum 50000 "Scales" implements IScale
{
    Extensible = true;

    DefaultImplementation = IScale = "Scale Default";
    UnknownValueImplementation = IScale = "Scale Unknown";

    value(1; waldo)
    {
        Caption = 'waldo';
        Implementation = Iscale = "Scale waldo";
    }
    value(2; Vjeko)
    {
        Caption = 'Vjeko';
        Implementation = Iscale = "Scale Vjeko";
    }
}