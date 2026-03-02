#pragma once
// Il est interdit de modifier ce fichier !!

#include <string>

/**
 * La classe `Tracker` compte le nombre d'objets de type Tracker en mémoire.
 */
class Tracker
{
public:
// Constructeur
    Tracker()
        : _id { ++_next_id }
    {
        ++_count;
    }
// constructeur par copie
    Tracker(const Tracker& o)
        : _id { o._id }
    {
        ++_count;
        ++_copies;
    }
// opérateur d'assignation par copie
    Tracker& operator=(const Tracker& other)
    {
        _id = other._id;
        ++_copies;
        return *this;
    }
// constructeur par déplacement
    Tracker(Tracker&& o) noexcept
        : _id { o._id }
    {
        _count++;
    }
// opérateur d'assignation par déplacement
    Tracker& operator=(Tracker&& other) noexcept = default;
// destructeur
    ~Tracker() { --_count; }

    static int count() { return _count; }
    static int copies() { return _copies; }

    int id() const { return _id; }

private:
    int               _id;
    inline static int _count   = 0; // Nombre d'instance de Tracker en mémoire.
    inline static int _copies  = 0; // Nombre de fois que des Tracker ont été copié.
    inline static int _next_id = 0;
};

void assert_no_copy(std::string const& test_name);
void assert_mem_count(std::string const& test_name, int count);

// Il est interdit de modifier ce fichier !!
