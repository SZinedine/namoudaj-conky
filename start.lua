----------------------------------
-- Author:      Zineddine SAIBI
-- Software:    Namoudaj Conky
-- Type:        Template for Conky
-- Version:     0.1 (07 Sep 2021)
-- License:     GPL-3.0
-- Repository:  https://www.github.com/SZinedine/namoudaj-conky
----------------------------------

require 'abstract'

-- This is a Demo
-- replace the content of the following function to create your own conky theme
function start()
    local rings_radius = 150
    local thickness = 3

    ring_anticlockwise(277, 200, rings_radius, thickness, 400, 140, cpu_percent(), 100, color_frompercent(tonumber(cpu_percent())))   -- cpu ring
    ring_clockwise(555, 200, rings_radius, thickness, 0, 360, cpu_temperature(), 100, main_fg)     -- temperature ring
    ring_clockwise(833, 200, rings_radius, thickness, -40, 220, memory_percent(), 100, main_fg)    -- ram ring

    if has_battery then
        rectangle_leftright(160, 400, 800, thickness, battery_percent(), 100, color_frompercent_reverse(tonumber(battery_percent())))   -- battery rectangle / line
        write(535, 400+20, "Battery", 14, main_text_color)
        write(125, 407, battery_percent() .. "%", 14, main_text_color)
    end

    -- titles
    write(267, 200+rings_radius+20, "CPU", 14, main_text_color)
    write(515, 200+rings_radius+20, "Temperature", 14, main_text_color)
    write(813, 200+rings_radius+20, "Memory", 14, main_text_color)

    -- text values
    write(267, 210, cpu_percent() .. "%", 14, main_text_color)
    write(545, 210, cpu_temperature() .. "°C", 14, main_text_color)
    write(823, 210, memory_percent() .. "%", 14, main_text_color)

    -- clock
    write(430, 530, time_hrmin(), 80, main_text_color)
end



function conky_main()
    if conky_window == nil then
        return
    elseif colors_defined == false then
        io.stderr:write("Fatal Error. Please define a theme")
    end
    local cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable,
                                         conky_window.visual, conky_window.width,
                                         conky_window.height)
    cr = cairo_create(cs)

    if tonumber(updates()) > time_before_start then
        start()
    end

    cairo_destroy(cr)
    cairo_surface_destroy(cs)
    cr = nil
end
