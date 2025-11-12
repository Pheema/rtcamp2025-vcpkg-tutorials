#pragma once

#include <fmt/core.h>

#include <string_view>

void sayHello(std::string_view name)
{
    fmt::println("Hello, {}!", name);
}