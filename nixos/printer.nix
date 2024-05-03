{ ... }:

{
  services.klipper = {
    enable = true;
    user = "root";
    group = "root";
    settings = {
      stepper_x = {
        step_pin = "PC2";
        dir_pin = "PB9";
        enable_pin = "!PC3";
        microsteps = 16;
        rotation_distance = 40;
        endstop_pin = "^PA5";
        position_endstop = 0;
        position_max = 235;
        homing_speed = 40;
      };

      stepper_y = {
        step_pin = "PB8";
        dir_pin = "PB7";
        enable_pin = "!PC3";
        microsteps = 16;
        rotation_distance = 40;
        endstop_pin = "^PA6";
        position_endstop = 0;
        position_max = 235;
        homing_speed = 40;
      };

      stepper_z = {
        step_pin = "PB6";
        dir_pin = "!PB5";
        enable_pin = "!PC3";
        microsteps = 16;
        rotation_distance = 8;
        endstop_pin = "^PA7";
        position_endstop = 0;
        position_max = 250;
        homing_speed = 20;
      };

      extruder = {
        max_extrude_only_distance = 100.0;
        step_pin = "PB4";
        dir_pin = "PB3";
        enable_pin = "!PC3";
        microsteps = 16;
        rotation_distance = 34.406;
        nozzle_diameter = 0.400;
        filament_diameter = 1.750;
        heater_pin = "PA1";
        sensor_type = "EPCOS 100K B57560G104F";
        sensor_pin = "PC5";
        control = "pid";
        pid_Kp = 21.527;
        pid_Ki = 1.063;
        pid_Kd = 108.982;
        min_temp = 0;
        max_temp = 260;
      };

      heater_bed = {
        heater_pin = "PA2";
        sensor_type = "EPCOS 100K B57560G104F";
        sensor_pin = "PC4";
        control = "pid";
        pid_kp = 70.405;
        pid_ki = 1.229;
        pid_kd = 1008.553;
        min_temp = 0;
        max_temp = 110;
      };

      fan = {
        pin = "PA0";
      };

      mcu = {
        serial = "/dev/ttyUSB0";
        restart_method = "command";
      };

      printer = {
        kinematics = "cartesian";
        max_velocity = 300;
        max_accel = 5000;
        max_z_velocity = 5;
        square_corner_velocity = 5.0;
        max_z_accel = 100;
      };

      bed_screws = {
        screw1 = "30,25";
        screw2 = "200,25";
        screw3 = "200,195";
        screw4 = "30,195";
      };

      bed_mesh = {
        speed = 50;
        horizontal_move_z = 2;
        mesh_min = "20, 20";
        mesh_max = "200, 200";
        probe_count = "3, 3";
      };

      "output_pin beeper" = {
        pin = "PB13";
      };

      virtual_sdcard = {
        path = "/var/lib/moonraker/gcodes/";
      };
    };
  };
  services.moonraker = {
    enable = true;
    user = "root";
    group = "root";
    address = "0.0.0.0";
    settings = {
      authorization = {
        force_logins = false;
        cors_domains = [ "localhost" "*.local" ];
        trusted_clients = [ "0.0.0.0" "127.0.0.1" "192.168.2.0/24" "10.147.20.0/24" ];
      };
    };
  };
  services.mainsail = {
    enable = true;
  };
}
