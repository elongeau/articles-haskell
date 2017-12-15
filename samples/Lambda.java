public class LambdaSample {
    public static void main(String... args) {
        final List<Integer> res = Stream.of(1, 2, 3, 4) //
                .map(x -> x * 2) //
                .collect(Collectors.toList());

        System.out.println(res);

    }
}