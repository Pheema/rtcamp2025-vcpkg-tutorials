#include "hello.h"

#include <argparse/argparse.hpp>
#include <fpng.h>

int main(int argc, char **argv)
{
    argparse::ArgumentParser parser{"hello-vcpkg"};
    parser.add_argument("-n", "--name")
        .help("name to greet")
        .default_value(std::string{"vcpkg"});
    parser.parse_args(argc, argv);

    const auto name = parser.get<std::string>("--name");
    sayHello(name);

    // overlay port を作成した fpng を意図的に利用するだけのコード
    fpng::fpng_init();
    if (fpng::fpng_cpu_supports_sse41())
    {
        fmt::println("[fpng] SSE4.1 is supported");
    }
    else
    {
        fmt::println("[fpng] SSE4.1 is not supported");
    }

    return 0;
}