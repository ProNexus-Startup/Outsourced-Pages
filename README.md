# Outsourced-Pages
Create the following pages in flutter: 
- Available Experts Page (do this page within lib/pages/available_experts_page.dart):
![image](https://github.com/ProNexus-Startup/Outsourced-Pages/assets/79029818/3940220e-bf1c-4571-9b4d-54885a187509)

- Call Tracker Page (do this page within lib/pages/available_experts_page.dart):
![image](https://github.com/ProNexus-Startup/Outsourced-Pages/assets/79029818/4e705241-1151-4389-b79d-d2a7ea5a6d2c)

Also edit lib/pages/components/sub_menu.dart, lib/pages/components/top_menu.dart so that they appear as shown here on both the avaialble experts and call tracker pages:
![image](https://github.com/ProNexus-Startup/Outsourced-Pages/assets/79029818/d0ad79b5-75ce-441b-b819-b9c20d0288b6)

Next, edit the lib/utils/formatting/app_theme.dart file if necessary with any color changes so we can keep those consistent across the whole app.

Finally, edit the lib/utils/global_bloc.dart file so the filter works. I have added sample data in the lib/utils/sample_data.dart file so you can test how everything is working. My models for available experts and call trackers can also be found in lib/utils/models. Make sure this sample data flows through global_bloc through the expertsList and callsList variables.