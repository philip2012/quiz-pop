import UIKit

// QuizPop v7 — UIKit-only capstone application.
// Set the storyboard's initial ViewController class to ViewController.
// No AI, network access, or third-party dependencies.

// MARK: - Curated offline quiz bank
// No Foundation Models, Wikipedia API, network, token generation, or AI review.
// The answer key is authored as the full choice text, then its index is derived
// automatically so grading cannot become desynchronized after shuffling.
private struct QuizQuestion {
    let question: String
    let choices: [String]
    let correctIndex: Int
    let explanation: String
}

private enum OfflineQuizBank {
    static let topics = ["Intel CPU", "PCB", "Mathematics", "Swift", "Space"]

    private static func item(_ question: String, _ choices: [String],
                             answer: String, explanation: String) -> QuizQuestion {
        precondition(choices.count == 4 && Set(choices).count == 4)
        guard let correctIndex = choices.firstIndex(of: answer) else {
            preconditionFailure("A bundled answer must exactly match a choice")
        }
        return QuizQuestion(question: question, choices: choices,
                            correctIndex: correctIndex, explanation: explanation)
    }

    // Five checked questions per topic and difficulty. Question and choice order
    // are shuffled for each new attempt; the answer index follows the choice.
    private static let bank: [String: [String: [QuizQuestion]]] = [
        "Intel CPU": [
            "Easy": [
                item("What does CPU stand for?",
                     ["Central Processing Unit", "Computer Power Utility", "Core Processing Upload", "Central Peripheral Unit"],
                     answer: "Central Processing Unit",
                     explanation: "CPU means Central Processing Unit: the part that executes program instructions."),
                item("Which of these is an Intel CPU product family?",
                     ["GeForce RTX", "Core i5", "Radeon RX", "DDR5"],
                     answer: "Core i5",
                     explanation: "Core i5 is an Intel processor family; the other names refer to graphics products or memory."),
                item("What is the main role of a CPU?",
                     ["Store files permanently", "Display pixels directly", "Execute program instructions", "Supply electricity to the computer"],
                     answer: "Execute program instructions",
                     explanation: "A CPU executes instructions, including arithmetic, logic, and control operations."),
                item("What is a CPU core?",
                     ["A part of a processor that executes instructions", "A type of computer monitor", "A power connector", "A cooling fan"],
                     answer: "A part of a processor that executes instructions",
                     explanation: "A core contains execution resources for running instructions."),
                item("Which unit is commonly used to express CPU clock frequency?",
                     ["Gigabytes (GB)", "Watts (W)", "Gigahertz (GHz)", "Pixels (px)"],
                     answer: "Gigahertz (GHz)",
                     explanation: "Clock frequency is measured in hertz, commonly reported in GHz for modern CPUs."),
            ],
            "Medium": [
                item("Which cache level is typically closest to an Intel CPU core?",
                     ["L3 cache", "L1 cache", "System RAM", "SSD storage"],
                     answer: "L1 cache",
                     explanation: "L1 cache is typically the smallest and closest cache level to a CPU core."),
                item("On supported Intel CPUs, what does Hyper-Threading allow?",
                     ["Two physical CPUs share one socket", "One physical core expose two logical processors", "A CPU run without RAM", "A GPU become a CPU core"],
                     answer: "One physical core expose two logical processors",
                     explanation: "Hyper-Threading is Intel’s implementation of simultaneous multithreading on supported cores."),
                item("What does an integrated GPU do?",
                     ["Provides graphics processing within a processor or SoC", "Replaces the computer’s SSD", "Increases the number of CPU sockets", "Stores the operating system"],
                     answer: "Provides graphics processing within a processor or SoC",
                     explanation: "An integrated GPU provides graphics capabilities without requiring a separate discrete graphics card."),
                item("What is Intel Turbo Boost designed to do on supported CPUs?",
                     ["Permanently lock the CPU at base frequency", "Dynamically raise clock frequency when limits permit", "Double installed RAM capacity", "Turn CPU cache into storage"],
                     answer: "Dynamically raise clock frequency when limits permit",
                     explanation: "Turbo Boost raises operating frequency when thermal, power, and other limits allow."),
                item("Which instruction-set family is used by many Intel desktop and laptop CPUs?",
                     ["ARM-only AArch64", "RISC-V only", "x86-64", "SPARC V9 only"],
                     answer: "x86-64",
                     explanation: "Many modern Intel Core and Xeon processors implement the x86-64 instruction set."),
            ],
            "Hard": [
                item("What is the main benefit of out-of-order execution in a modern CPU?",
                     ["It executes every instruction in source-code order", "It uses execution units while independent instructions are ready", "It eliminates all branch mispredictions", "It prevents the CPU from using caches"],
                     answer: "It uses execution units while independent instructions are ready",
                     explanation: "Out-of-order execution schedules ready independent operations to keep execution resources busy."),
                item("Which sequence generally goes from faster, smaller memory toward slower, larger memory?",
                     ["DRAM → L3 → L2 → L1", "L1 → L2 → L3 → DRAM", "L3 → DRAM → L1 → L2", "SSD → L1 → L3 → DRAM"],
                     answer: "L1 → L2 → L3 → DRAM",
                     explanation: "Typical CPU memory hierarchies place L1 nearest the core, followed by L2, L3, and system DRAM."),
                item("Why do CPUs perform branch prediction?",
                     ["To guess likely control flow and keep the pipeline supplied", "To verify every disk file", "To increase monitor refresh rates", "To prevent all software bugs"],
                     answer: "To guess likely control flow and keep the pipeline supplied",
                     explanation: "Prediction allows speculative fetching and execution before a branch direction is resolved."),
                item("What does TDP commonly stand for in processor specifications?",
                     ["Total Data Processing", "Thermal Design Power", "Turbo Device Priority", "Thread Distribution Parameter"],
                     answer: "Thermal Design Power",
                     explanation: "Thermal Design Power is a thermal-design specification; it is not necessarily maximum instantaneous CPU power."),
                item("How does simultaneous multithreading (SMT) differ from adding physical cores?",
                     ["SMT adds a separate processor die", "SMT exposes multiple logical threads on one physical core", "SMT doubles the number of physical ALUs by definition", "SMT disables cache sharing"],
                     answer: "SMT exposes multiple logical threads on one physical core",
                     explanation: "SMT allows a physical core to maintain architectural state for multiple logical threads while sharing execution resources."),
            ],
        ],
        "PCB": [
            "Easy": [
                item("What does PCB stand for in electronics?",
                     ["Printed Circuit Board", "Personal Computer Battery", "Portable Control Box", "Power Cable Bundle"],
                     answer: "Printed Circuit Board",
                     explanation: "A printed circuit board supports components and connects them through conductive patterns."),
                item("What usually carries electrical signals across a PCB?",
                     ["Silkscreen labels", "Copper traces", "Plastic mounting feet", "Solder mask"],
                     answer: "Copper traces",
                     explanation: "Copper traces form conductive pathways between component connections."),
                item("Which process commonly attaches components electrically to PCB pads?",
                     ["Painting", "Laminating paper", "Soldering", "Polishing"],
                     answer: "Soldering",
                     explanation: "Soldering creates conductive metal joints between component terminals and pads."),
                item("What is a common purpose of solder mask?",
                     ["Make the board generate power", "Protect copper and limit unintended solder bridges", "Replace all copper traces", "Program the microcontroller"],
                     answer: "Protect copper and limit unintended solder bridges",
                     explanation: "Solder mask coats much of the copper surface while leaving intended solderable areas exposed."),
                item("What are component names and reference labels often printed in?",
                     ["Silkscreen", "Copper core", "Dielectric breakdown", "Battery electrolyte"],
                     answer: "Silkscreen",
                     explanation: "The silkscreen layer commonly shows reference designators and assembly markings."),
            ],
            "Medium": [
                item("What does a plated via commonly connect in a multilayer PCB?",
                     ["Two or more copper layers", "The PCB to a Wi-Fi network", "Two unrelated computer cases", "The board to a display backlight"],
                     answer: "Two or more copper layers",
                     explanation: "A plated via provides an electrical path between copper layers."),
                item("What is FR-4 commonly used for in PCB construction?",
                     ["A conductive signal trace", "A fiberglass-reinforced epoxy insulating laminate", "A removable lithium battery", "A soldering iron tip"],
                     answer: "A fiberglass-reinforced epoxy insulating laminate",
                     explanation: "FR-4 is a common glass-reinforced epoxy laminate used as a PCB substrate."),
                item("What typically happens during reflow soldering for surface-mount components?",
                     ["Solder paste is heated until it melts and forms joints", "All copper traces are removed", "Components are attached using magnets", "Every component is drilled through the board"],
                     answer: "Solder paste is heated until it melts and forms joints",
                     explanation: "In reflow, solder paste melts and solidifies to form SMT component connections."),
                item("Why place a decoupling capacitor close to an IC power pin?",
                     ["To store the operating system", "To reduce local power-supply voltage disturbances", "To increase the PCB thickness", "To replace the clock oscillator"],
                     answer: "To reduce local power-supply voltage disturbances",
                     explanation: "A nearby decoupling capacitor helps supply transient current and reduce supply noise."),
                item("What is a ground plane on a PCB?",
                     ["A large conductive area tied to circuit ground", "A printed manufacturer logo", "A protective shipping cover", "A software debugger view"],
                     answer: "A large conductive area tied to circuit ground",
                     explanation: "Ground planes provide a low-impedance ground/reference structure when appropriately designed."),
            ],
            "Hard": [
                item("Why are high-speed differential traces often routed as a matched pair?",
                     ["To preserve controlled differential signaling and reduce interference", "To eliminate any need for ground", "To make all traces conduct DC only", "To replace integrated circuits"],
                     answer: "To preserve controlled differential signaling and reduce interference",
                     explanation: "Matched routing helps maintain differential impedance and signal timing."),
                item("What primarily influences a PCB trace’s characteristic impedance?",
                     ["Silkscreen font and logo color", "Trace geometry and surrounding dielectric", "Package label text", "The monitor connected to the PC"],
                     answer: "Trace geometry and surrounding dielectric",
                     explanation: "Trace dimensions, return-path geometry, and dielectric properties determine transmission-line impedance."),
                item("Why are thermal-relief spokes used on pads connected to large copper planes?",
                     ["To isolate the pad electrically forever", "To make soldering easier by reducing heat flow into the plane", "To remove the need for solder", "To improve Wi-Fi passwords"],
                     answer: "To make soldering easier by reducing heat flow into the plane",
                     explanation: "Thermal relief reduces heat sinking into the plane during soldering while retaining electrical connection."),
                item("What does a PCB design-rule check (DRC) mainly test?",
                     ["Guaranteed functional correctness of firmware", "Layout constraints such as spacing and trace widths", "Whether a CPU is fast enough", "The final retail price"],
                     answer: "Layout constraints such as spacing and trace widths",
                     explanation: "DRC checks configured layout rules; it does not prove the electrical design will function."),
                item("In high-density interconnect boards, what is a microvia commonly used for?",
                     ["Connecting nearby copper layers with a very small via", "Replacing every component with a resistor", "Labeling copper traces with text", "Increasing board area"],
                     answer: "Connecting nearby copper layers with a very small via",
                     explanation: "Microvias are small, often laser-drilled interlayer connections used in HDI PCB designs."),
            ],
        ],
        "Mathematics": [
            "Easy": [
                item("What is 7 × 8?",
                     ["54", "56", "64", "48"],
                     answer: "56",
                     explanation: "Seven groups of eight equal 56."),
                item("What is 1/2 + 1/4?",
                     ["1/4", "2/6", "3/4", "1"],
                     answer: "3/4",
                     explanation: "One-half is two-fourths; adding one-fourth gives three-fourths."),
                item("What is the perimeter of a rectangle with sides 5 cm and 3 cm?",
                     ["8 cm", "15 cm", "16 cm", "30 cm"],
                     answer: "16 cm",
                     explanation: "A rectangle’s perimeter is 2 × (5 + 3) = 16 cm."),
                item("What is 9 squared?",
                     ["18", "72", "81", "90"],
                     answer: "81",
                     explanation: "9 squared means 9 × 9 = 81."),
                item("Solve x + 7 = 12.",
                     ["3", "4", "5", "6"],
                     answer: "5",
                     explanation: "Subtract 7 from both sides to obtain x = 5."),
            ],
            "Medium": [
                item("Solve 3x − 4 = 14.",
                     ["4", "5", "6", "7"],
                     answer: "6",
                     explanation: "Add 4 to get 3x = 18, then divide by 3: x = 6."),
                item("What is the area of a triangle with base 10 cm and height 7 cm?",
                     ["17 cm²", "35 cm²", "70 cm²", "140 cm²"],
                     answer: "35 cm²",
                     explanation: "Area = (10 × 7)/2 = 35 cm²."),
                item("A right triangle has legs of 6 cm and 8 cm. What is its hypotenuse?",
                     ["9 cm", "10 cm", "12 cm", "14 cm"],
                     answer: "10 cm",
                     explanation: "The Pythagorean theorem gives √(6² + 8²) = √100 = 10 cm."),
                item("Which expression is equal to x² − 9?",
                     ["(x − 9)(x + 1)", "(x − 3)(x + 3)", "(x − 3)²", "(x + 3)²"],
                     answer: "(x − 3)(x + 3)",
                     explanation: "This is a difference of squares: x² − 3² = (x − 3)(x + 3)."),
                item("What is the arithmetic mean of 4, 8, and 12?",
                     ["6", "7", "8", "9"],
                     answer: "8",
                     explanation: "(4 + 8 + 12)/3 = 24/3 = 8."),
            ],
            "Hard": [
                item("What is the derivative of f(x) = 3x² − 2x?",
                     ["3x − 2", "6x − 2", "6x", "6x + 2"],
                     answer: "6x − 2",
                     explanation: "Differentiate each term: d(3x²)/dx = 6x and d(−2x)/dx = −2."),
                item("What are the real solutions of x² − 5x + 6 = 0?",
                     ["1 and 6", "−2 and −3", "2 and 3", "−1 and −6"],
                     answer: "2 and 3",
                     explanation: "The polynomial factors into (x − 2)(x − 3), so x = 2 or 3."),
                item("When flipping three fair coins, what is the probability of getting exactly two heads?",
                     ["1/8", "1/4", "3/8", "1/2"],
                     answer: "3/8",
                     explanation: "There are C(3,2) = 3 favorable outcomes among 2³ = 8 equally likely outcomes."),
                item("What is the definite integral of 2x from x = 0 to x = 2?",
                     ["2", "3", "4", "8"],
                     answer: "4",
                     explanation: "An antiderivative is x²; evaluating 2² − 0² gives 4."),
                item("Solve log₂(x) = 5 for x > 0.",
                     ["10", "16", "25", "32"],
                     answer: "32",
                     explanation: "By the definition of logarithms, x = 2⁵ = 32."),
            ],
        ],
        "Swift": [
            "Easy": [
                item("Which Swift keyword declares a constant binding?",
                     ["var", "let", "func", "class"],
                     answer: "let",
                     explanation: "The let keyword declares a binding whose value cannot be reassigned."),
                item("What does print(\"Hi\") normally do in Swift?",
                     ["Displays a system alert", "Writes Hi to standard output", "Creates an iPhone button", "Saves text to iCloud"],
                     answer: "Writes Hi to standard output",
                     explanation: "print writes textual output, usually visible in the Xcode debug console."),
                item("What does [Int] represent in Swift?",
                     ["A dictionary with String keys", "An array of integers", "A single Boolean", "A function returning Int"],
                     answer: "An array of integers",
                     explanation: "[Int] is shorthand for Array<Int>."),
                item("Which statement runs code when a condition is true?",
                     ["import", "struct", "if", "extension"],
                     answer: "if",
                     explanation: "An if statement conditionally executes its body."),
                item("Which characters begin a single-line comment in Swift?",
                     ["//", "##", "<!--", "**"],
                     answer: "//",
                     explanation: "Swift uses // for single-line comments."),
            ],
            "Medium": [
                item("What does the type String? mean in Swift?",
                     ["A String or nil", "An array of Strings", "A String that cannot be empty", "A compile-time constant only"],
                     answer: "A String or nil",
                     explanation: "The question mark denotes an Optional<String> that may hold a value or nil."),
                item("What does the nil-coalescing operator ?? do?",
                     ["Always throws an error", "Uses a fallback when an optional is nil", "Forces a value to become nil", "Creates a new class"],
                     answer: "Uses a fallback when an optional is nil",
                     explanation: "a ?? b evaluates to the unwrapped a if present, otherwise the fallback b."),
                item("What does the mutating keyword allow in a Swift struct method?",
                     ["Changing the struct instance’s stored properties", "Making a network request", "Importing a framework", "Creating a UIKit storyboard"],
                     answer: "Changing the struct instance’s stored properties",
                     explanation: "A mutating method can modify the stored properties of its value-type instance."),
                item("What must happen when a Swift guard condition fails?",
                     ["Execution continues into the next line", "The current scope must be exited", "The app must show an alert", "The variable becomes a constant"],
                     answer: "The current scope must be exited",
                     explanation: "The else branch of guard must exit the enclosing scope, for example with return or throw."),
                item("Which Swift declaration creates a value type?",
                     ["class", "protocol", "struct", "actor"],
                     answer: "struct",
                     explanation: "Struct instances have value semantics, unlike ordinary class instances."),
            ],
            "Hard": [
                item("What is a primary purpose of a Swift actor?",
                     ["Serialize access to actor-isolated mutable state", "Turn all methods into C functions", "Disable asynchronous code", "Convert value types to reference-counted pointers"],
                     answer: "Serialize access to actor-isolated mutable state",
                     explanation: "Actor isolation helps protect mutable state from concurrent data races."),
                item("What does async let enable in Swift concurrency?",
                     ["Creating concurrently executing child tasks for async values", "Making every function synchronous", "Replacing all error handling", "Disabling structured concurrency"],
                     answer: "Creating concurrently executing child tasks for async values",
                     explanation: "An async let binding creates a child task; multiple bindings can run concurrently within structured concurrency."),
                item("Why use weak for a class reference in Swift?",
                     ["To prevent strong-reference cycles when appropriate", "To make a value immutable", "To perform deep copies automatically", "To turn off ARC globally"],
                     answer: "To prevent strong-reference cycles when appropriate",
                     explanation: "Weak references do not increment the referenced object’s strong retain count."),
                item("What does @MainActor indicate on a Swift declaration?",
                     ["It is isolated to the main actor", "It must run in a detached thread", "It is stored in UserDefaults", "It can never access UI state"],
                     answer: "It is isolated to the main actor",
                     explanation: "@MainActor marks a declaration as main-actor-isolated, often used for UI-related state."),
                item("Which protocols are combined by Swift’s Codable typealias?",
                     ["Hashable and Equatable", "Sendable and Identifiable", "Encodable and Decodable", "Sequence and Collection"],
                     answer: "Encodable and Decodable",
                     explanation: "Codable is a typealias for the combination of Encodable and Decodable."),
            ],
        ],
        "Space": [
            "Easy": [
                item("Which planet is the largest in our Solar System?",
                     ["Earth", "Neptune", "Jupiter", "Saturn"],
                     answer: "Jupiter",
                     explanation: "Jupiter is the largest planet by diameter and mass in the Solar System."),
                item("Which planet is commonly called the Red Planet?",
                     ["Mars", "Venus", "Mercury", "Uranus"],
                     answer: "Mars",
                     explanation: "Mars appears reddish mainly because of iron oxides on its surface."),
                item("What does Earth orbit?",
                     ["Jupiter", "The Moon", "The Sun", "Polaris"],
                     answer: "The Sun",
                     explanation: "Earth revolves around the Sun approximately once per year."),
                item("What is the name of the galaxy containing our Solar System?",
                     ["Andromeda", "Milky Way", "Triangulum", "Sombrero Galaxy"],
                     answer: "Milky Way",
                     explanation: "The Solar System lies within the Milky Way galaxy."),
                item("What is Earth’s natural satellite called?",
                     ["Europa", "Titan", "The Moon", "Phobos"],
                     answer: "The Moon",
                     explanation: "The Moon is Earth’s only permanent natural satellite."),
            ],
            "Medium": [
                item("A light-year is a unit of what?",
                     ["Time", "Distance", "Brightness", "Temperature"],
                     answer: "Distance",
                     explanation: "A light-year is the distance light travels in vacuum during one Julian year."),
                item("What mainly causes the Moon’s phases as observed from Earth?",
                     ["The Moon changing its own brightness", "Earth blocking sunlight every night", "Our view of the Moon’s sunlit half changing", "The Sun orbiting the Moon"],
                     answer: "Our view of the Moon’s sunlit half changing",
                     explanation: "The geometry of the Sun, Earth, and Moon determines how much of the sunlit lunar hemisphere we see."),
                item("Between which planets is the main asteroid belt located?",
                     ["Earth and Mars", "Mars and Jupiter", "Jupiter and Saturn", "Uranus and Neptune"],
                     answer: "Mars and Jupiter",
                     explanation: "The main asteroid belt lies between the orbits of Mars and Jupiter."),
                item("Which gas makes up most of Earth’s atmosphere by volume?",
                     ["Oxygen", "Carbon dioxide", "Nitrogen", "Argon"],
                     answer: "Nitrogen",
                     explanation: "Dry air near Earth’s surface is approximately 78% nitrogen by volume."),
                item("Which force is primarily responsible for ocean tides on Earth?",
                     ["Magnetism from Mars", "Gravitational effects of the Moon and Sun", "Solar wind pressure alone", "Earth’s atmospheric oxygen"],
                     answer: "Gravitational effects of the Moon and Sun",
                     explanation: "Differences in lunar and solar gravitational pull contribute to Earth’s tidal bulges."),
            ],
            "Hard": [
                item("What does the exoplanet transit method primarily measure?",
                     ["Small periodic dips in a star’s observed brightness", "The color of planet soil directly", "Radio echoes reflected from a planet", "The planet’s magnetic field on Earth"],
                     answer: "Small periodic dips in a star’s observed brightness",
                     explanation: "A planet crossing in front of its star can produce a repeatable reduction in received starlight."),
                item("In astronomy, what is redshift?",
                     ["A shift of observed spectral features toward longer wavelengths", "A change in star mass caused by cooling", "A telescope rotating counterclockwise", "A direct measure of a planet’s radius"],
                     answer: "A shift of observed spectral features toward longer wavelengths",
                     explanation: "Redshift means wavelengths are stretched relative to their reference values; it can arise from motion, cosmological expansion, or gravity."),
                item("Approximately what is Earth’s escape speed at the surface, neglecting air resistance and rotation?",
                     ["1.1 km/s", "5.6 km/s", "11.2 km/s", "30 km/s"],
                     answer: "11.2 km/s",
                     explanation: "Escape speed near Earth’s surface is about 11.2 kilometres per second under these assumptions."),
                item("What describes the Roche limit?",
                     ["The boundary where tides can disrupt a self-gravitating satellite", "The maximum speed of a rocket", "The location of the asteroid belt", "The distance at which light slows to zero"],
                     answer: "The boundary where tides can disrupt a self-gravitating satellite",
                     explanation: "Inside the Roche limit, tidal forces can overcome the self-gravity of a sufficiently weak satellite."),
                item("What does a Hertzsprung–Russell diagram typically compare?",
                     ["Star luminosity and surface temperature", "Planet mass and day length", "Galaxy distance and diameter only", "Telescope aperture and focal length"],
                     answer: "Star luminosity and surface temperature",
                     explanation: "An H–R diagram plots stellar luminosity (or absolute magnitude) against temperature or spectral class."),
            ],
        ],
    ]

    static func questions(topic: String, difficulty: String) -> [QuizQuestion] {
        bank[topic]?[difficulty] ?? []
    }
}

private struct QuizAttempt: Codable, Identifiable {
    let id: UUID
    let date: Date
    let topic: String
    let difficulty: String
    let score: Int
    let total: Int

    private static let storageKey = "QuizPop.attempts.v1"

    static func load() -> [QuizAttempt] {
        guard let data = UserDefaults.standard.data(forKey: storageKey),
              let attempts = try? JSONDecoder().decode([QuizAttempt].self, from: data) else {
            return []
        }
        return attempts
    }

    static func save(_ attempts: [QuizAttempt]) {
        if let data = try? JSONEncoder().encode(attempts) {
            UserDefaults.standard.set(data, forKey: storageKey)
        }
    }

    static func clear() {
        UserDefaults.standard.removeObject(forKey: storageKey)
    }
}


// MARK: - UIKit theme, reusable answer cell

private enum QuizPalette {
    static let mint = UIColor(red: 0.00, green: 0.76, blue: 0.67, alpha: 1)
    static let softMint = UIColor(red: 0.88, green: 0.97, blue: 0.95, alpha: 1)
    static let softGreen = UIColor(red: 0.89, green: 0.97, blue: 0.91, alpha: 1)
    static let softOrange = UIColor(red: 1.00, green: 0.94, blue: 0.86, alpha: 1)
}

private enum AnswerAppearance {
    case normal, selected, correct, incorrect
}

private final class QuizAnswerCell: UITableViewCell {
    static let reuseID = "QuizAnswerCell"

    private let panel = UIView()
    private let letterLabel = UILabel()
    private let answerLabel = UILabel()
    private let statusIcon = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear

        panel.translatesAutoresizingMaskIntoConstraints = false
        letterLabel.translatesAutoresizingMaskIntoConstraints = false
        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        statusIcon.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(panel)
        [letterLabel, answerLabel, statusIcon].forEach { panel.addSubview($0) }

        panel.layer.cornerRadius = 14
        letterLabel.layer.cornerRadius = 20
        letterLabel.clipsToBounds = true
        letterLabel.font = .systemFont(ofSize: 15, weight: .bold)
        letterLabel.textAlignment = .center
        answerLabel.font = .preferredFont(forTextStyle: .body)
        answerLabel.adjustsFontForContentSizeCategory = true
        answerLabel.numberOfLines = 3
        statusIcon.contentMode = .scaleAspectFit

        NSLayoutConstraint.activate([
            panel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            panel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            panel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            panel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            letterLabel.leadingAnchor.constraint(equalTo: panel.leadingAnchor, constant: 14),
            letterLabel.centerYAnchor.constraint(equalTo: panel.centerYAnchor),
            letterLabel.widthAnchor.constraint(equalToConstant: 40),
            letterLabel.heightAnchor.constraint(equalToConstant: 40),
            statusIcon.trailingAnchor.constraint(equalTo: panel.trailingAnchor, constant: -15),
            statusIcon.centerYAnchor.constraint(equalTo: panel.centerYAnchor),
            statusIcon.widthAnchor.constraint(equalToConstant: 23),
            statusIcon.heightAnchor.constraint(equalToConstant: 23),
            answerLabel.leadingAnchor.constraint(equalTo: letterLabel.trailingAnchor, constant: 14),
            answerLabel.trailingAnchor.constraint(equalTo: statusIcon.leadingAnchor, constant: -10),
            answerLabel.centerYAnchor.constraint(equalTo: panel.centerYAnchor),
            answerLabel.topAnchor.constraint(greaterThanOrEqualTo: panel.topAnchor, constant: 10),
            answerLabel.bottomAnchor.constraint(lessThanOrEqualTo: panel.bottomAnchor, constant: -10)
        ])
    }

    required init?(coder: NSCoder) { fatalError("Use the programmatic initializer") }

    func configure(letter: String, answer: String, appearance: AnswerAppearance) {
        letterLabel.text = letter
        answerLabel.text = answer
        answerLabel.textColor = .label
        letterLabel.textColor = .label
        letterLabel.backgroundColor = QuizPalette.softMint

        let symbol: String
        switch appearance {
        case .normal:
            panel.backgroundColor = .secondarySystemGroupedBackground
            symbol = "circle"
            statusIcon.tintColor = .tertiaryLabel
        case .selected:
            panel.backgroundColor = QuizPalette.softMint
            symbol = "checkmark.circle.fill"
            statusIcon.tintColor = QuizPalette.mint
        case .correct:
            panel.backgroundColor = QuizPalette.softGreen
            symbol = "checkmark.circle.fill"
            statusIcon.tintColor = .systemGreen
        case .incorrect:
            panel.backgroundColor = QuizPalette.softOrange
            symbol = "xmark.circle.fill"
            statusIcon.tintColor = .systemOrange
        }
        statusIcon.image = UIImage(systemName: symbol)
        accessibilityLabel = "Answer \(letter): \(answer)"
        accessibilityTraits = [.button]
    }
}

// MARK: - Monolithic UIKit view controller

final class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private enum Screen { case home, quiz, results, review }

    private var screen: Screen = .home
    private var topic = "Intel CPU"
    private var difficulty = "Easy"
    private var mode = "Practice"
    private var activeTopic = "Intel CPU"
    private var activeDifficulty = "Easy"
    private var activeMode = "Practice"
    private var questions: [QuizQuestion] = []
    private var currentQuestion = 0
    private var selectedChoice: Int?
    private var isRevealed = false
    private var selectedAnswers: [Int] = []
    private var disputedIndices: Set<Int> = []
    private var attempts = QuizAttempt.load()
    private var latestAttemptID: UUID?

    private weak var answersTable: UITableView?
    private weak var answerButton: UIButton?

    private var gradedTotal: Int { max(0, questions.count - disputedIndices.count) }
    private var score: Int {
        selectedAnswers.enumerated().filter { index, selected in
            questions.indices.contains(index) &&
            !disputedIndices.contains(index) &&
            selected == questions[index].correctIndex
        }.count
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.setNavigationBarHidden(true, animated: false)
        render()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Reload only after the table has actually entered a window.
        if let table = answersTable, table.window != nil { table.reloadData() }
    }

    // MARK: UIKit layout helpers

    private func text(_ value: String, size: CGFloat = 17,
                      weight: UIFont.Weight = .regular,
                      color: UIColor = .label) -> UILabel {
        let label = UILabel()
        label.text = value
        label.textColor = color
        label.font = .systemFont(ofSize: size, weight: weight)
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        return label
    }

    private func vertical(spacing: CGFloat = 14) -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = spacing
        stack.alignment = .fill
        return stack
    }

    private func horizontal(spacing: CGFloat = 10) -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = spacing
        stack.alignment = .center
        return stack
    }

    private func primaryButton(_ title: String, systemImage: String? = nil,
                               action: @escaping () -> Void) -> UIButton {
        var config = UIButton.Configuration.filled()
        config.title = title
        config.image = systemImage.flatMap { UIImage(systemName: $0) }
        config.imagePadding = 8
        config.baseBackgroundColor = QuizPalette.mint
        config.baseForegroundColor = .white
        config.cornerStyle = .capsule
        let button = UIButton(configuration: config)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        button.addAction(UIAction { _ in action() }, for: .touchUpInside)
        button.heightAnchor.constraint(greaterThanOrEqualToConstant: 54).isActive = true
        return button
    }

    private func secondaryButton(_ title: String,
                                 action: @escaping () -> Void) -> UIButton {
        var config = UIButton.Configuration.bordered()
        config.title = title
        config.baseForegroundColor = QuizPalette.mint
        config.cornerStyle = .capsule
        let button = UIButton(configuration: config)
        button.addAction(UIAction { _ in action() }, for: .touchUpInside)
        button.heightAnchor.constraint(greaterThanOrEqualToConstant: 44).isActive = true
        return button
    }

    private func spacer(_ height: CGFloat) -> UIView {
        let v = UIView()
        v.heightAnchor.constraint(equalToConstant: height).isActive = true
        return v
    }

    private func card(_ children: [UIView], spacing: CGFloat = 10) -> UIView {
        let container = UIView()
        container.backgroundColor = .secondarySystemGroupedBackground
        container.layer.cornerRadius = 16
        let stack = vertical(spacing: spacing)
        stack.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(stack)
        children.forEach { stack.addArrangedSubview($0) }
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: container.topAnchor, constant: 16),
            stack.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -16),
            stack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16)
        ])
        return container
    }

    private func render() {
        answersTable = nil
        answerButton = nil
        view.subviews.forEach { $0.removeFromSuperview() }

        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.keyboardDismissMode = .onDrag
        scroll.alwaysBounceVertical = true
        view.addSubview(scroll)
        let content = vertical(spacing: 20)
        content.translatesAutoresizingMaskIntoConstraints = false
        scroll.addSubview(content)

        NSLayoutConstraint.activate([
            scroll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scroll.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            content.topAnchor.constraint(equalTo: scroll.contentLayoutGuide.topAnchor, constant: 22),
            content.leadingAnchor.constraint(equalTo: scroll.contentLayoutGuide.leadingAnchor, constant: 22),
            content.trailingAnchor.constraint(equalTo: scroll.contentLayoutGuide.trailingAnchor, constant: -22),
            content.bottomAnchor.constraint(equalTo: scroll.contentLayoutGuide.bottomAnchor, constant: -30),
            content.widthAnchor.constraint(equalTo: scroll.frameLayoutGuide.widthAnchor, constant: -44)
        ])
        switch screen {
        case .home: buildHome(into: content)
        case .quiz: buildQuiz(into: content)
        case .results: buildResults(into: content)
        case .review: buildReview(into: content)
        }
        // Do not call table.layoutIfNeeded() or reloadData() before attachment.
        if let table = answersTable, table.window != nil { table.reloadData() }
    }

    private func header(_ content: UIStackView, exit: Bool = false) {
        let row = horizontal()
        row.addArrangedSubview(text("QuizPop", size: 29, weight: .bold))
        row.addArrangedSubview(UIView())
        if exit {
            let exitButton = secondaryButton("Exit") { [weak self] in self?.confirmExit() }
            row.addArrangedSubview(exitButton)
        }
        content.addArrangedSubview(row)
    }

    // MARK: Home screen

    private func buildHome(into content: UIStackView) {
        content.addArrangedSubview(spacer(18))
        content.addArrangedSubview(text("QuizPop", size: 36, weight: .bold))
        let symbol = UIImageView(image: UIImage(systemName: "square.stack.3d.up.fill"))
        symbol.tintColor = QuizPalette.mint
        symbol.contentMode = .scaleAspectFit
        symbol.heightAnchor.constraint(equalToConstant: 60).isActive = true
        content.addArrangedSubview(symbol)
        content.addArrangedSubview(text("Learn something new.", size: 28, weight: .bold))
        content.addArrangedSubview(text("Five multiple-choice questions per round. Fully offline and built with UIKit.",
                                        size: 15, color: .secondaryLabel))

        content.addArrangedSubview(text("Choose a topic", size: 18, weight: .semibold))
        var menuConfig = UIButton.Configuration.bordered()
        menuConfig.title = topic
        menuConfig.image = UIImage(systemName: "chevron.down")
        menuConfig.imagePlacement = .trailing
        menuConfig.baseForegroundColor = .label
        let topicButton = UIButton(configuration: menuConfig)
        topicButton.contentHorizontalAlignment = .leading
        topicButton.showsMenuAsPrimaryAction = true
        topicButton.menu = UIMenu(children: OfflineQuizBank.topics.map { candidate in
            UIAction(title: candidate, state: candidate == topic ? .on : .off) { [weak self] _ in
                self?.topic = candidate
                self?.render()
            }
        })
        topicButton.heightAnchor.constraint(equalToConstant: 52).isActive = true
        content.addArrangedSubview(topicButton)

        content.addArrangedSubview(text("Difficulty", size: 18, weight: .semibold))
        let levels = ["Easy", "Medium", "Hard"]
        let levelControl = UISegmentedControl(items: levels)
        levelControl.selectedSegmentIndex = levels.firstIndex(of: difficulty) ?? 0
        levelControl.addTarget(self, action: #selector(difficultyChanged(_:)), for: .valueChanged)
        content.addArrangedSubview(levelControl)

        content.addArrangedSubview(text("Quiz mode", size: 18, weight: .semibold))
        let modes = ["Practice", "Exam"]
        let modeControl = UISegmentedControl(items: modes)
        modeControl.selectedSegmentIndex = modes.firstIndex(of: mode) ?? 0
        modeControl.addTarget(self, action: #selector(modeChanged(_:)), for: .valueChanged)
        content.addArrangedSubview(modeControl)
        content.addArrangedSubview(text(mode == "Practice"
                                        ? "See corrections and explanations after each answer."
                                        : "See the answer key only after completing the quiz.",
                                        size: 14, color: .secondaryLabel))
        content.addArrangedSubview(primaryButton("Start Quiz", systemImage: "play.fill") { [weak self] in
            self?.startOfflineQuiz()
        })
        content.addArrangedSubview(text("5 topics · 3 difficulty levels · 75 curated questions. Each new round shuffles choices.",
                                        size: 13, color: .secondaryLabel))

        if !attempts.isEmpty { buildHistory(into: content) }
    }

    @objc private func difficultyChanged(_ control: UISegmentedControl) {
        difficulty = ["Easy", "Medium", "Hard"][control.selectedSegmentIndex]
    }

    @objc private func modeChanged(_ control: UISegmentedControl) {
        mode = ["Practice", "Exam"][control.selectedSegmentIndex]
        render()
    }

    private func buildHistory(into content: UIStackView) {
        content.addArrangedSubview(spacer(12))
        let row = horizontal()
        row.addArrangedSubview(text("Your progress", size: 22, weight: .bold))
        row.addArrangedSubview(UIView())
        row.addArrangedSubview(secondaryButton("Clear") { [weak self] in self?.confirmClear() })
        content.addArrangedSubview(row)

        let best = attempts.map { Double($0.score) / Double(max(1, $0.total)) }.max() ?? 0
        let average = attempts.map { Double($0.score) / Double(max(1, $0.total)) }
            .reduce(0, +) / Double(attempts.count)
        content.addArrangedSubview(card([
            text("Completed quizzes: \(attempts.count)", weight: .semibold),
            text("Best accuracy: \(Int(best * 100))%"),
            text("Average accuracy: \(Int(average * 100))%")
        ]))
        content.addArrangedSubview(text("Recent attempts", size: 18, weight: .semibold))
        for attempt in attempts.prefix(5) {
            let dateText = attempt.date.formatted(date: .abbreviated, time: .shortened)
            content.addArrangedSubview(card([
                text("\(attempt.topic) · \(attempt.difficulty)", weight: .semibold),
                text("\(attempt.score)/\(attempt.total) correct · \(dateText)", size: 14, color: .secondaryLabel)
            ], spacing: 5))
        }
    }

    private func confirmClear() {
        let alert = UIAlertController(title: "Clear history?",
                                      message: "This removes your saved quiz attempts.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Clear", style: .destructive) { [weak self] _ in
            self?.attempts.removeAll()
            QuizAttempt.clear()
            self?.render()
        })
        present(alert, animated: true)
    }

    // MARK: Quiz screen with real UITableView and UITableViewCell

    private func buildQuiz(into content: UIStackView) {
        guard questions.indices.contains(currentQuestion) else { return }
        let question = questions[currentQuestion]
        header(content, exit: true)
        content.addArrangedSubview(spacer(12))
        let info = horizontal()
        info.addArrangedSubview(text(activeTopic + "\n" + activeDifficulty + " · " + activeMode,
                                     size: 16, weight: .semibold))
        info.addArrangedSubview(UIView())
        info.addArrangedSubview(text("\(currentQuestion + 1) / \(questions.count)",
                                     size: 17, weight: .bold))
        content.addArrangedSubview(info)
        let progress = UIProgressView(progressViewStyle: .default)
        progress.progressTintColor = QuizPalette.mint
        progress.progress = Float(currentQuestion + 1) / Float(questions.count)
        content.addArrangedSubview(progress)
        content.addArrangedSubview(spacer(5))
        content.addArrangedSubview(text(question.question, size: 25, weight: .bold))
        content.addArrangedSubview(text(isRevealed ? "Answer checked" : "Choose one answer",
                                        size: 16, color: .secondaryLabel))

        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.isScrollEnabled = false
        table.showsVerticalScrollIndicator = false
        table.register(QuizAnswerCell.self, forCellReuseIdentifier: QuizAnswerCell.reuseID)
        table.dataSource = self
        table.delegate = self
        table.rowHeight = 108
        table.heightAnchor.constraint(equalToConstant: 4 * 108).isActive = true
        content.addArrangedSubview(table)
        answersTable = table

        if isRevealed && activeMode == "Practice" {
            let wasCorrect = selectedChoice == question.correctIndex
            let flagged = disputedIndices.contains(currentQuestion)
            let heading = flagged ? "Question flagged" : (wasCorrect ? "Correct!" : "Not quite")
            content.addArrangedSubview(card([
                text(heading, size: 19, weight: .bold,
                     color: wasCorrect ? .systemGreen : .systemOrange),
                text(question.explanation, size: 16),
                secondaryButton(flagged ? "Include in score" : "Flag questionable question") { [weak self] in
                    self?.toggleFlag(at: self?.currentQuestion ?? 0)
                    self?.render()
                }
            ]))
        }

        let label = isRevealed
            ? (currentQuestion == questions.count - 1 ? "See Results" : "Next Question")
            : (activeMode == "Exam" ? "Submit Answer" : "Check Answer")
        let button = primaryButton(label) { [weak self] in self?.submitOrAdvance() }
        button.isEnabled = isRevealed || selectedChoice != nil
        content.addArrangedSubview(button)
        answerButton = button
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard tableView === answersTable, screen == .quiz else { return 0 }
        return questions.indices.contains(currentQuestion) ? questions[currentQuestion].choices.count : 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: QuizAnswerCell.reuseID,
                                                 for: indexPath) as! QuizAnswerCell
        guard questions.indices.contains(currentQuestion),
              questions[currentQuestion].choices.indices.contains(indexPath.row) else {
            return cell
        }
        let question = questions[currentQuestion]
        let appearance: AnswerAppearance
        if isRevealed && activeMode == "Practice" {
            if indexPath.row == question.correctIndex { appearance = .correct }
            else if indexPath.row == selectedChoice { appearance = .incorrect }
            else { appearance = .normal }
        } else {
            appearance = indexPath.row == selectedChoice ? .selected : .normal
        }
        let letter = String(UnicodeScalar(65 + indexPath.row)!)
        cell.configure(letter: letter, answer: question.choices[indexPath.row], appearance: appearance)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard tableView === answersTable, screen == .quiz, !isRevealed,
              questions.indices.contains(currentQuestion),
              questions[currentQuestion].choices.indices.contains(indexPath.row) else { return }
        selectedChoice = indexPath.row
        answerButton?.isEnabled = true
        if tableView.window != nil { tableView.reloadData() }
    }

    private func submitOrAdvance() {
        guard screen == .quiz, questions.indices.contains(currentQuestion) else { return }
        if isRevealed { advanceQuiz(); return }
        guard let selectedChoice else { return }
        selectedAnswers.append(selectedChoice)
        isRevealed = true
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        if activeMode == "Exam" { advanceQuiz() }
        else { render() }
    }

    private func advanceQuiz() {
        guard isRevealed else { return }
        if currentQuestion == questions.count - 1 {
            let attempt = QuizAttempt(id: UUID(), date: Date(), topic: activeTopic,
                                      difficulty: activeDifficulty, score: score, total: gradedTotal)
            latestAttemptID = attempt.id
            attempts.insert(attempt, at: 0)
            attempts = Array(attempts.prefix(30))
            QuizAttempt.save(attempts)
            screen = .results
        } else {
            currentQuestion += 1
            selectedChoice = nil
            isRevealed = false
        }
        render()
    }

    private func confirmExit() {
        let alert = UIAlertController(title: "Leave this quiz?",
                                      message: "This attempt will not be saved.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue", style: .cancel))
        alert.addAction(UIAlertAction(title: "Exit", style: .destructive) { [weak self] _ in
            self?.screen = .home
            self?.render()
        })
        present(alert, animated: true)
    }

    // MARK: Results, review, and sharing

    private func buildResults(into content: UIStackView) {
        header(content)
        content.addArrangedSubview(spacer(24))
        content.addArrangedSubview(text("Quiz complete!", size: 31, weight: .bold))
        content.addArrangedSubview(text(gradedTotal == 0 ? "No graded score" : "\(score) / \(gradedTotal)",
                                        size: 54, weight: .bold))
        if gradedTotal > 0 {
            let progress = UIProgressView(progressViewStyle: .default)
            progress.progressTintColor = QuizPalette.mint
            progress.progress = Float(score) / Float(gradedTotal)
            content.addArrangedSubview(progress)
        }
        content.addArrangedSubview(text(disputedIndices.isEmpty
                                        ? "Review your answers or try another round."
                                        : "\(disputedIndices.count) flagged question(s) excluded from scoring.",
                                        size: 15, color: .secondaryLabel))
        content.addArrangedSubview(primaryButton("Review Answers", systemImage: "list.bullet.rectangle") { [weak self] in
            self?.screen = .review
            self?.render()
        })
        content.addArrangedSubview(secondaryButton("Retry Same Quiz") { [weak self] in
            guard let self else { return }
            self.startQuiz(self.questions, topic: self.activeTopic,
                           difficulty: self.activeDifficulty, shuffle: false)
        })
        content.addArrangedSubview(secondaryButton("New Shuffled Round") { [weak self] in
            guard let self else { return }
            let items = OfflineQuizBank.questions(topic: self.activeTopic, difficulty: self.activeDifficulty)
            self.startQuiz(items.shuffled(), topic: self.activeTopic,
                           difficulty: self.activeDifficulty)
        })
        content.addArrangedSubview(secondaryButton("Share Result") { [weak self] in self?.shareResult() })
        content.addArrangedSubview(secondaryButton("Change Topic") { [weak self] in
            self?.screen = .home
            self?.render()
        })
    }

    private func buildReview(into content: UIStackView) {
        content.addArrangedSubview(secondaryButton("Back to Results") { [weak self] in
            self?.screen = .results
            self?.render()
        })
        content.addArrangedSubview(text("Answer review", size: 32, weight: .bold))
        content.addArrangedSubview(text("\(activeTopic) · \(activeDifficulty)",
                                        size: 15, color: .secondaryLabel))
        for index in questions.indices {
            let question = questions[index]
            let chosen = selectedAnswers.indices.contains(index) ? selectedAnswers[index] : -1
            let correct = chosen == question.correctIndex
            let flagged = disputedIndices.contains(index)
            let yourChoice = question.choices.indices.contains(chosen) ? question.choices[chosen] : "—"
            let flagTitle = flagged ? "Include in score" : "Flag questionable question"
            let flag = secondaryButton(flagTitle) { [weak self] in
                self?.toggleFlag(at: index)
                self?.render()
            }
            content.addArrangedSubview(card([
                text("Question \(index + 1)" + (flagged ? " · Flagged" : ""),
                     size: 19, weight: .bold,
                     color: correct ? .systemGreen : .systemOrange),
                text(question.question, size: 17, weight: .semibold),
                text("Your answer: \(yourChoice)"),
                text("Correct answer: \(question.choices[question.correctIndex])",
                     color: .systemGreen),
                text(question.explanation, size: 15, color: .secondaryLabel),
                flag
            ]))
        }
    }

    private func shareResult() {
        let message = "I scored \(score)/\(gradedTotal) on QuizPop: \(activeTopic) (\(activeDifficulty))!"
        let activity = UIActivityViewController(activityItems: [message], applicationActivities: nil)
        if let popover = activity.popoverPresentationController {
            popover.sourceView = view
            popover.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 1, height: 1)
        }
        present(activity, animated: true)
    }

    private func toggleFlag(at index: Int) {
        guard questions.indices.contains(index) else { return }
        if disputedIndices.contains(index) { disputedIndices.remove(index) }
        else { disputedIndices.insert(index) }
        if let id = latestAttemptID,
           let saved = attempts.firstIndex(where: { $0.id == id }) {
            let old = attempts[saved]
            attempts[saved] = QuizAttempt(id: old.id, date: old.date,
                                          topic: old.topic, difficulty: old.difficulty,
                                          score: score, total: gradedTotal)
            QuizAttempt.save(attempts)
        }
    }

    // MARK: Deterministic question selection and scoring

    private func startOfflineQuiz() {
        let items = OfflineQuizBank.questions(topic: topic, difficulty: difficulty)
        guard items.count == 5 else {
            let alert = UIAlertController(title: "Questions unavailable",
                                          message: "The selected category does not contain five questions.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        startQuiz(items.shuffled(), topic: topic, difficulty: difficulty)
    }

    private func startQuiz(_ items: [QuizQuestion], topic: String,
                           difficulty: String, shuffle: Bool = true) {
        questions = shuffle ? items.map { question in
            let shuffledIndices = Array(question.choices.indices).shuffled()
            let reordered = shuffledIndices.map { question.choices[$0] }
            let newAnswer = shuffledIndices.firstIndex(of: question.correctIndex)!
            return QuizQuestion(question: question.question, choices: reordered,
                                correctIndex: newAnswer, explanation: question.explanation)
        } : items
        activeTopic = topic
        activeDifficulty = difficulty
        activeMode = mode
        currentQuestion = 0
        selectedChoice = nil
        isRevealed = false
        selectedAnswers = []
        disputedIndices = []
        latestAttemptID = nil
        screen = .quiz
        render()
    }
}
