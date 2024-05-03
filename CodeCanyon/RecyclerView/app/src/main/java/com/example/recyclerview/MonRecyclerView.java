package com.example.recyclerview;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import java.util.ArrayList;

public class MonRecyclerView extends RecyclerView.Adapter<MonRecyclerView.MonRecyclerViewHolder>{
    private Context context;
    private ArrayList<Integer> liste_entiers; // On créer un objet selon le type que l'on veut affiger

    public MonRecyclerView(Context context, ArrayList<Integer> liste_entiers){
        this.context = context;
        this.liste_entiers = liste_entiers;
    }

    @NonNull
    @Override
    public MonRecyclerViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType){
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.)
    }
}
