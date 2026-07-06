{
  title = "Lambda Cubes";
  date = "2026-07-06";
  styles = [ "./style.css" ];
  scripts = [
    {
      src = "./coc-cube.ts";
      module = true;
    }
    {
      src = "./reduction-cube.ts";
      module = true;
    }
  ];
}
