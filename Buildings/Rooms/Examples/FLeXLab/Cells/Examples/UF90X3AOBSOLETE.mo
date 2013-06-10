within Buildings.Rooms.Examples.FLeXLab.Cells.Examples;
model UF90X3AOBSOLETE "Example demonstrating the use of UF90X3A"
  import Buildings;
  extends Buildings.Rooms.Examples.FLeXLab.Cells.UF90X3AOBSOLETE(
                                                         roo(nPorts=2,
        nConExtWin=nConExtWin,
      redeclare package Medium = Air,
      nConBou=0), sla(redeclare package Medium = Water, m_flow_nominal=0.063));

      //fixme - m_flow_nominal is currently unknown. 0.063 kg/s is a placeholder value

  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.CombiTimeTable shaPos(table=[0,1; 86400,1])
    "Position of the shade"
    annotation (Placement(transformation(extent={{-102,74},{-82,94}})));
  Modelica.Blocks.Sources.CombiTimeTable airCon(table=[0,0.1,293.15; 86400,0.1,293.15])
    "Inlet air conditions (y[1] = m_flow, y[2] = T)"
    annotation (Placement(transformation(extent={{-142,-4},{-122,16}})));
  Modelica.Blocks.Sources.CombiTimeTable watCon(table=[0,0.06,303.15; 86400,0.06,
        303.15]) "Inlet water conditions (y[1] = m_flow, y[2] =  T)"
    annotation (Placement(transformation(extent={{-114,-72},{-94,-52}})));
  Buildings.Fluid.Sources.MassFlowSource_T
                                 watIn(
    nPorts=1,
    use_m_flow_in=true,
    use_T_in=true,
    redeclare package Medium = Water)
    "Inlet water conditions (from central plant)"
    annotation (Placement(transformation(extent={{-56,-76},{-36,-56}})));
  Buildings.Fluid.Sources.MassFlowSource_T
                                 airIn(
    use_m_flow_in=true,
    use_T_in=true,
    nPorts=1,
    redeclare package Medium = Air) "Inlet air conditions (from AHU)"
    annotation (Placement(transformation(extent={{-90,-8},{-70,12}})));
  Buildings.Fluid.Sources.Boundary_pT
                            airOut(nPorts=1, redeclare package Medium = Air)
    annotation (Placement(transformation(extent={{-92,-38},{-72,-18}})));
  Modelica.Blocks.Routing.Replicator replicator(nout=max(1, nConExtWin))
    annotation (Placement(transformation(extent={{-70,74},{-50,94}})));
  Buildings.Fluid.Sources.Boundary_pT
                            watOut(nPorts=1, redeclare package Medium = Water)
    "Water outlet"
                 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={44,-66})));

  package Air =
      Buildings.Media.GasesConstantDensity.MoistAirUnsaturated
    "Air model in the room model";
  package Water = Buildings.Media.ConstantPropertyLiquidWater
    "Water model in the slab model";

  parameter Integer nConExtWin = 1
    "Number of external constructions which include windows";

  Buildings.Rooms.Examples.FLeXLab.Cells.UF90X3A
                                               cellA
    annotation (Placement(transformation(extent={{94,36},{134,76}})));
equation
  connect(shaPos.y[1], replicator.u) annotation (Line(
      points={{-81,84},{-72,84}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(watIn.ports[1], sla.port_a)    annotation (Line(
      points={{-36,-66},{-18,-66}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(sla.port_b,watOut. ports[1])    annotation (Line(
      points={{2,-66},{34,-66}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(watCon.y[1], watIn.m_flow_in) annotation (Line(
      points={{-93,-62},{-78,-62},{-78,-58},{-56,-58}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(watCon.y[2], watIn.T_in) annotation (Line(
      points={{-93,-62},{-58,-62}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(airCon.y[1], airIn.m_flow_in) annotation (Line(
      points={{-121,6},{-110,6},{-110,10},{-90,10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(airCon.y[2], airIn.T_in) annotation (Line(
      points={{-121,6},{-92,6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(roo.uSha[1], replicator.y[1]) annotation (Line(
      points={{-22,16},{-32,16},{-32,84},{-49,84}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(airIn.ports[1], roo.ports[1]) annotation (Line(
      points={{-70,2},{-38,2},{-38,-10},{-15,-10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(airOut.ports[1], roo.ports[2]) annotation (Line(
      points={{-72,-28},{-38,-28},{-38,-10},{-15,-10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(sla.surf_a, roo.surf_surBou[1]) annotation (Line(
      points={{-4,-56},{-4,-36},{-4,-14},{-3.8,-14}},
      color={191,0,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -150},{200,150}}), graphics), Commands(file="Resources/Scripts/Dymola/Rooms/Examples/FLeXLab/Cells/Examples/UF90X3A.mos"
        "Simulate and Plot"));
end UF90X3AOBSOLETE;