public class ClosureSample {
    public static void main(String... args) {
        Stream.of(1, 2, 3, 4)
            .map(add(2))
            .forEach(System.out::println);
    }

    private static Function<Integer, Integer> add(final int i) {
        return x -> x + i; // je suis une closure
    }

}