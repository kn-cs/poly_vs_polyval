## Poly Versus Polyval

This is the source code repository of the work [Poly Versus Polyval](https://eprint.iacr.org/2026/2707.pdf), authored by 
[Kaushik Nath](kaushik.nath@yahoo.in) & [Palash Sarkar](palash@isical.ac.in) of [Indian Statistical Institute, Kolkata, India](https://www.isical.ac.in).
This work studies the performances of usual reduction and Montgomery reduction over binary extension fields.

To report a bug or make a comment regarding the implementations please drop a mail to: [Kaushik Nath](kaushik.nath@yahoo.in).

---

### Prerequisite
    
Install the library "libcpucycles" from https://cpucycles.cr.yp.to. Use installation mode for
"developers with an unprivileged account" if you face problems installing using the "sysadmins"
mode. Update the PATH variables in the ".profile" file within the home directory as mentioned
https://cpucycles.cr.yp.to/install.html.

Open the file "/sys/devices/system/cpu/intel_pstate/no_turbo" in sudo mode and set the value
to "1". This will disable the "Turbo Boost" feature of the system.

Open the file "/sys/devices/system/cpu/smt/control" in sudo mode and set the value to "off".
This will disable the "Hyper-Threading" feature of the system.

Execute the command "sudo sysctl kernel.perf_event_paranoid=2". This will set the Linux
perf_event interface; /proc/sys/kernel/perf_event_paranoid to at most 2 as described in
https://cpucycles.cr.yp.to/counters.html.

---

### Generate benchmarks for various message sizes

Replace the word "native" in "poly.sh" with the code-name of your processor and then
execute "sh poly.sh". Without the replacement done, the benchmarks wll be generated
in the "./benchmarks/native" folder. Note that benchmarks with code-names "ivybridge",
"tigerlake" and "meteorlake" already exist in the repository. To avoid overwriting please
avoid exact names of these folders.

    
### Generate benchmarks for maximum message size of 4 MB = 33554432 bits

Execute "sh poly_speed.sh".

---    
