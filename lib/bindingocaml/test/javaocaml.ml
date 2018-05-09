let () = Java.init [| "-Djava.class.path=../srcs/ocaml-java/srcs/java/ocaml-java.jar:../srcs/javacryptocode/jarfiles/unicrypt-2.3.jar:../srcs/javacryptocode/jarfiles/jnagmp-2.0.0.jar:../srcs/javacryptocode/jarfiles/jna-4.5.0.jar:../srcs/javacryptocode/schulze.jar:." |]
let () =  Printexc.record_backtrace true

let valid_ballot = List.map string_of_int [0; 1; 1; 0; 0; 1; 0; 0; 0]

let _ =
 let pkey = "49228593607874990954666071614777776087" in 
 let skey = "60245260967214266009141128892124363925" in
 let encvbal = Javaocamlbinding.enc_ballot valid_ballot pkey in (* encrypt the ballot *)
 let rperm = Javaocamlbinding.row_perm encvbal pkey in (* row shift *)
 let rzkp = Javaocamlbinding.row_perm_zkp encvbal pkey in (* zero knowledge proof *)
 let cperm = Javaocamlbinding.column_perm rperm pkey in  (* column permutation *)
 let czkp = Javaocamlbinding.column_perm_zkp rperm pkey in (* zero knowledge proof *)
 let decbal = Javaocamlbinding.dec_ballot cperm skey in (* decrypt the ballot *)
 let dzkp = Javaocamlbinding.dec_ballot_zkp cperm skey in  (* zero knowledge proof *)
 print_endline "Plaintext ballot";
 List.iter (fun x -> print_endline x) valid_ballot;
 print_endline "Encrypted ballot";
 List.iter (fun x -> print_endline x) encvbal;
 print_endline "Row Permuted ballot";
 List.iter (fun x -> print_endline x) rperm;
 print_endline "Zero knowledge of row shuffle";
 print_endline rzkp;
 print_endline "Column permuted ballot";
 List.iter (fun x -> print_endline x) cperm;
 print_endline "Zero knowledge proof";
 print_endline czkp;
 print_endline "Decrypted permuted ballot";
 List.iter (fun x -> print_endline x) decbal;
 print_endline "Zeroknowledge proof of honest decryption";
 print_endline dzkp
