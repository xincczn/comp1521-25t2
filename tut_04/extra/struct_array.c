
struct student {
    int position;
    char name[10];
    int *secret_number;
};


/*
    Arrays
        To get an element of the array at a given index:
        
        Formuala: element_address = array_base_address + offset
        - offset = (index * size of the element)
  
    2D Arrays
        To get an element of the 2d array at a given index (row, col):
            Formula: element_address = array_base_address + offset
            - offset = ((MAX_COL * row) + col) * size of the element

    Structs  
        To get a field of the struct
        Formula: struct_base_address + offset
        - offset = sum of all fields before the one you want 


        element_address + struct_field_offset
*/

