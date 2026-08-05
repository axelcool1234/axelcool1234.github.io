{
  title = "MI450 WMMA and ds_load Scheduling via a DAG Mutation";
  date = "2026-08-05";
  styles = [ "./style.css" ];
  scripts = [
    {
      src = "./readyqueue.ts";
      module = true;
    }
    {
      src = "./tooearly.ts";
      module = true;
    }
    {
      src = "./dagedits.ts";
      module = true;
    }
    {
      src = "./budget.ts";
      module = true;
    }
    {
      src = "./dagrun.ts";
      module = true;
    }
  ];
}
