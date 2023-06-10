enum 50004 "MidJourney Setting" implements "IMidJourney Setting"
{
    Extensible = true;
    DefaultImplementation = "IMidJourney Setting" = "MJ Setting - None";

    value(0; None) { Implementation = "IMidJourney Setting" = "MJ Setting - None"; }
    value(1; Office) { Implementation = "IMidJourney Setting" = "MJ Setting - Office"; }
    value(2; Bar) { Implementation = "IMidJourney Setting" = "MJ Setting - Bar"; }
    value(3; Beach) { Implementation = "IMidJourney Setting" = "MJ Setting - Beach"; }

}